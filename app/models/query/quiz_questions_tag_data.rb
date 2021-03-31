class Query::QuizQuestionsTagData
  class TagData < OpenStruct
    def tag
      @tag ||= Tag.find(id)
    end

    def performance
      Rational(correct_count, total_count).to_f
    end
  end

  def initialize(quiz_questions)
    raise ArgumentError, "an ActiveRecord Relation must be passed" unless quiz_questions.is_a?(ActiveRecord::Relation)

    @quiz_questions = quiz_questions
  end

  def resolve
    total_data.map {|data|
      TagData.new data.attributes.merge(correct_count: correct_data[data.id])
    }
  end

  private

  def relation
    @relation ||= @quiz_questions.joins(:tags, :answer).group("tags.id")
  end

  def correct_data
    @correct_data ||= relation.where(answers: {correct: true}).count
  end

  def total_data
    @total_data ||= relation.select("tags.*, count(quiz_questions.id) AS total_count")
  end
end
