class User::CourseStatus
  # Completed chapters
  # Completed sections
  class ChapterStatus
    attr_reader :chapter, :sections_statuses
    delegate :title, :position, to: :chapter

    def initialize(params)
      @chapter = params[:chapter]
      @sections_statuses = params[:sections_statuses]
    end

    def completion_rate
      sections_statuses.count(&:completed?).fdiv(all_sections.size)
    end

    def all_sections
      Section.where(chapter: chapter)
    end

    def completed?
      sections_statuses.all?(&:completed?)
    end

    include Comparable
    def <=>(other)
      position <=> other.position
    end
  end

  class SectionStatus
    attr_reader :section

    def initialize(params)
      @section = params[:section]
      @completed = params[:completed]
    end

    def completed?
      @completed
    end

    def position
      section.position
    end

    include Comparable
    def <=>(other)
      position <=> other.position
    end
  end

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def completed_sections
    @completed_sections ||= user.completed_sections
  end

  def missing_sections
    @missing_sections ||= Section.includes(:chapter).where.not(id: completed_sections)
  end

  def chapter_statuses
    Chapter.all.map { |chapter| ChapterStatus.new(chapter: chapter, sections_statuses: section_statuses_for(chapter)) }
  end

  def sections_statuses
    @sections_statuses ||= (user.completed_sections.includes(:chapter).map { |section| SectionStatus.new(completed: true, section: section) } + missing_sections.map { |section| SectionStatus.new(completed: false, section: section) }).sort
  end

  def section_statuses_for(chapter)
    sections_statuses.select { |section_status| section_status.section.chapter == chapter }
  end
end
