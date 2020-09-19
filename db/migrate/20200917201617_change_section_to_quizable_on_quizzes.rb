class ChangeSectionToQuizableOnQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_reference :quizzes, :quizable, polymorphic: true
    Quiz.all.each do |quiz|
      quiz.update(quizable_id: quiz.section_id, quizable_type: "Section")
    end
    remove_reference :quizzes, :section, foreign_key: true
  end
end
