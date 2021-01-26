class User::CourseStatus
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
    @section_statuses ||= (user.completed_sections.includes(:chapter).map { |section| SectionStatus.new(completed: true, section: section, user: user) } + missing_sections.map { |section| SectionStatus.new(completed: false, section: section) }).sort
  end

  def section_statuses_for(chapter)
    section_statuses.select { |section_status| section_status.section.chapter == chapter }
  end
end
