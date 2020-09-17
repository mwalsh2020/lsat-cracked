class RemoveSectionIdFromQuestions < ActiveRecord::Migration[6.0]
  SECTION_IDS_WITH_QUESTIONS_QUERY = <<~SQL
    SELECT DISTINCT sections.id
    FROM sections
    JOIN questions ON questions.section_id = sections.id;
  SQL

  def up
    section_ids = connection.execute(SECTION_IDS_WITH_QUESTIONS_QUERY).to_a
    
    section_ids.map(&:values).flatten.each do |section_id|
      quiz_template = QuizTemplate.create!(quizable_id: section_id, quizable_type: "Section")
      section = Section.find(section_id)
      quiz_template.update!(questions: section.questions) 
    end

    remove_reference :questions, :section, foreign_key: true
  end

  def down
    add_reference :questions, :section, foreign_key: true
  end
end
