class CreateQuizQuestionAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_question_answers do |t|
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
