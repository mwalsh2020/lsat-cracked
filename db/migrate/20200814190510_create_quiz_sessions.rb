class CreateQuizSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
