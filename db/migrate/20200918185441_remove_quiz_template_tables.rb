class RemoveQuizTemplateTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :quiz_template_questions
    drop_table :quiz_templates
  end
end
