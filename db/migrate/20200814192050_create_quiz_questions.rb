class CreateQuizQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_questions do |t|
      t.references :quiz_session, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
