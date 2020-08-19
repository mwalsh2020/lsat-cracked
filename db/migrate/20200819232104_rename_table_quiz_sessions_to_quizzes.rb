class RenameTableQuizSessionsToQuizzes < ActiveRecord::Migration[6.0]
  def change
    rename_table :quiz_sessions, :quizzes
  end
end
