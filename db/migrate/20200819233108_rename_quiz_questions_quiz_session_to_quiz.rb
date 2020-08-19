class RenameQuizQuestionsQuizSessionToQuiz < ActiveRecord::Migration[6.0]
  def change
    remove_reference :quiz_questions, :quiz_session
    add_reference :quiz_questions, :quiz, foreign_key: true
  end
end
