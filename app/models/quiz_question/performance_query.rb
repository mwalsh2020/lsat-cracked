class QuizQuestion::PerformanceQuery
  def initialize(quiz_questions)
    raise ArgumentError, "an ActiveRecord Relation must be passed" unless quiz_questions.is_a?(ActiveRecord::Relation)

    @quiz_questions = quiz_questions
  end

  def tags
    @tags ||= data_attributes.map {|attrs| Tag::Performance.new(attrs)}.force
  end

  private

  def data_attributes
    total_data.lazy.map {|data| data.attributes.merge(correct_count: correct_data[data.id]) }
  end

  def relation
    @relation ||= @quiz_questions.joins(:tags, :answer).group("tags.id")
  end

  def correct_data
    @correct_data ||= relation.where(answers: {correct: true}).count
  end

  def total_data
    @total_data ||= relation.select(
      "tags.id",
      "tags.slug",
      "count(quiz_questions.id) AS total_count",
    )
  end
end
