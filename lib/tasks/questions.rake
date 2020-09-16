namespace :questions do
  desc "Wipes Course Content and feeds it with db/support yaml files"
  task import: :environment do
    yaml_file_paths = Dir.glob("db/support/*.yml")
    sections_data = yaml_file_paths.map do |yaml_file_path|
      file_string = File.open(yaml_file_path).read
      sections_data = YAML.safe_load(file_string)
      sections_data
    end.flatten

    sections_data.each do |section_data|
      section_data["questions"].map! do |question_data|
        question_data["answers"].map! do |answer_data|
          Answer.new(answer_data.except("explanation"))
        end
        Question.new(question_data.except("variables"))
      end

      Section
        .find_by(title: section_data["title"])
        .update(questions: section_data["questions"])
    end
  end
end
