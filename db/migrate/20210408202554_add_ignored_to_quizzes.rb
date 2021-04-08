class AddIgnoredToQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_column :quizzes, :ignored, :boolean, default: false, null: false
  end
end
