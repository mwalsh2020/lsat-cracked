class User::CourseStatus::ChapterStatus
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
