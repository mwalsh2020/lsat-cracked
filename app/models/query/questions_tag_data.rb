class Query::QuestionsTagData
  def initialize(questions)
    raise ArgumentError, "an ActiveRecord Relation must be passed" unless questions.is_a?(ActiveRecord::Relation)

    @questions = questions
  end

  def resolve
    total_data.lazy.map {|tag_id, count|
      [tag_id, Rational(correct_data[tag_id].to_i, count).to_f]
    }.to_h
  end

  private

  def relation
    @relation ||= QuizQuestion.where(question: Question.all).joins(:tags, :answer)
  end

  def correct_data
    relation.group("tags.id").where(answers: {correct: true}).count
  end

  def total_data
    relation.group("tags.id").count
  end
end
