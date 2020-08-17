class AddCompleteToQuizSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_sessions, :complete, :boolean, null: false, default: false
  end
end
