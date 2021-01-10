class User::CourseStatus
  # Completed chapters
  # Completed sections
  
  class ChapterStatus
    attr_reader :chapter, :section_statuses
    delegate :title, :position, to: :chapter

    def initialize(params)
      @chapter = params[:chapter]
      @section_statuses = params[:section_statuses]
    end

    def completion_rate
      section_statuses.count(&:completed?).fdiv(all_sections.size)
    end

    def all_sections
      Section.where(chapter: chapter)
    end

    def completed?
      section_statuses.all?(&:completed?)
    end

    include Comparable
    def <=>(other)
      position <=> other.position
    end
  end

  class SectionStatus
    attr_reader :section
    delegate :title, :position, :quiz_score, to: :section

    def initialize(params)
      @section = params[:section]
      @completed = params[:completed]
    end

    def completed?
      @completed
    end

    def quiz_score
      correct_answers.size.fdiv(section.quizzes.last.answers.size)
    end

    def correct_answers
      section.quizzes.last.answers.correct
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
    Chapter.all.map { |chapter| ChapterStatus.new(chapter: chapter, section_statuses: section_statuses_for(chapter)) }
  end

  def section_statuses
    @section_statuses ||= (user.completed_sections.includes(:chapter).map { |section| SectionStatus.new(completed: true, section: section) } + missing_sections.map { |section| SectionStatus.new(completed: false, section: section) }).sort
  end

  def section_statuses_for(chapter)
    section_statuses.select { |section_status| section_status.section.chapter == chapter }
  end
end
