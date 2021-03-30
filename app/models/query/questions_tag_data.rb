class Query::QuestionsTagData
  def initialize(questions)
    raise ArgumentError, "an ActiveRecord Relation must be passed" unless questions.is_a?(ActiveRecord::Relation)

    @questions = questions
  end
end
