class RemoveQuizTemplateTables < ActiveRecord::Migration[6.0]
  def change
    QuizTemplateQuestion.all.each { |qtq| QuizableQuestion.create!(question: qtq.question, quizable: qtq.quiz_template.quizable) }
    drop_table :quiz_template_questions
    drop_table :quiz_templates
  end
end
