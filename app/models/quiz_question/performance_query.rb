class QuizQuestion::PerformanceQuery
  def initialize(quiz_questions)
    raise ArgumentError, "an ActiveRecord Relation must be passed" unless quiz_questions.is_a?(ActiveRecord::Relation)

    @quiz_questions = quiz_questions
  end

  def tags_attributes
    present_tags_attributes + missing_tags_attributes
  end

  def charts
    OpenStruct.new(
      tags: Charts::Tags.new(tags)
    )
  end

  def missing_tags
    Tag.where.not(id: Tag.joins(:questions).where(questions: {quiz_questions: @quiz_questions}).distinct)
  end

  def missing_tags_attributes
    missing_tags.select(:id, :slug, "0 AS correct_count, 0 AS total_count").as_json
  end

  def present_tags_attributes
    data.as_json
  end

  def relation
    @relation ||= @quiz_questions.joins(:tags, :answer).group("tags.id")
  end

  def correct_count_query
    <<~SQL
      SELECT COUNT(*)
      FROM quiz_questions
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
