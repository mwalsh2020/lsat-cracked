class User::CourseStatus::Performance
  include ActiveModel::Model

  attr_accessor :course_status

  def tags
    @tags ||= Tag::PerformanceCollection.new(performance_data)
  end

  def missing_tags_count
    @missing_tags_count ||= Tag.count - course_status.user.tags.count
  end

  private

  def performance_data
    @performance_data ||= QuizQuestion::PerformanceQuery.new(course_status.user.quiz_questions).result
  end
end

