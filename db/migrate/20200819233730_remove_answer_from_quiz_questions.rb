class RemoveAnswerFromQuizQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :quiz_questions, :answer
  end
end
