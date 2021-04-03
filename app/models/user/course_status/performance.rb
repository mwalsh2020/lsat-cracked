class User::CourseStatus::Performance
  include ActiveModel::Model

  attr_accessor :course_status

  def tags
    @tags ||= Tag::PerformanceCollection.new(performance_data)
  end

  def missing_tags
    @missing_tags ||= Tag.count - user.tags.count
  end

  private

  def performance_data
    @performance_data ||= QuizQuestion::PerformanceQuery.new(course_status.user.quiz_questions).result
  end
end

