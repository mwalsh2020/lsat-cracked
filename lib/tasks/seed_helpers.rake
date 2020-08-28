namespace :db do
  namespace :seed do
    desc "Wipes Course Content and feeds it with db/support yaml files"
    task course_content: :environment do
      yaml_file_paths = Dir.glob("db/support/*.yml")

      yaml_file_paths.each do |yaml_file_path|
        file_string = File.open(yaml_file_path).read
        sections_data = YAML.safe_load(file_string)
        chapter_data = yaml_file_path.match(/\/(?<position>\d+)-(?<title>\w+)/)
        puts "- Creating chapter #{chapter_data[:title]}"
        new_chapter = Chapter.create!(title: chapter_data[:title])
        sections_data.each do |section_data|
          puts "  - Creating section #{section_data['title']}"
          section = new_chapter.sections.create!(title: section_data["title"])

          section_data["questions"].each do |question_data|
            puts "    - Creating question #{question_data['prompt']}"
            question = section.questions.create!(question_data.except("answers", "variables"))

            question_data["answers"].each do |answer_data|
              puts "      - Creating answer #{answer_data['content']}"
              question.answers.create!(answer_data)
            end
          end
        end
      end
    end
  end
end
