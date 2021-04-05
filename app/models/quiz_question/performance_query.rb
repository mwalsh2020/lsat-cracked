class QuizQuestion::PerformanceQuery
  def initialize(quiz_questions)
    raise ArgumentError, "an ActiveRecord Relation must be passed" unless quiz_questions.is_a?(ActiveRecord::Relation)

    @quiz_questions = quiz_questions
  end

  def result
    performances_attributes
  end

  private

  def performances_attributes
    data.as_json
  end

  def relation
    @relation ||= @quiz_questions.joins(:tags, :answer).group("tags.id")
  end

  def correct_count_query
    <<~SQL
      SELECT COUNT(*)
      FROM (#{@quiz_questions.to_sql}) quiz_questions
        INNER JOIN questions ON questions.id = quiz_questions.question_id
        INNER JOIN taggings ON taggings.taggable_type = 'Question' AND taggings.taggable_id = questions.id
        INNER JOIN answers ON answers.id = quiz_questions.answer_id
      WHERE answers.correct = true AND tags.id = taggings.tag_id
    SQL
  end

  def data
    @data ||= relation.select(
      "tags.id",
      "tags.slug",
      "count(quiz_questions.id) AS total_count",
      "(#{correct_count_query}) AS correct_count"
    )
  end
end
