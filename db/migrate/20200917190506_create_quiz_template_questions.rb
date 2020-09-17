class CreateQuizTemplateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_template_questions do |t|
      t.references :question, null: false, foreign_key: true
      t.references :quiz_template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
