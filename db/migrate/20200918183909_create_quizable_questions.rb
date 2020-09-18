class CreateQuizableQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :quizable_questions do |t|
      t.references :question, null: false, foreign_key: true
      t.references :quizable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
