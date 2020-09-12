def chapter_naming_data(yaml_file_path)
  chapter_data = yaml_file_path.match(/\/(?<position>\d+)-(?<title>\w+)/)
  file_string = File.open(yaml_file_path).read

  {
    title: chapter_data[:title].humanize.titlecase,
    position: chapter_data[:position].to_i,
    sections_data: YAML.safe_load(file_string),
  }
end

def create_answer(answer_data, question)
  puts "      - Creating answer #{answer_data['content']}"
  question.answers.create!(answer_data)
end

def create_question(question_data, section)
  puts "    - Creating question #{question_data['prompt']}"
  question = section.questions.create!(question_data.except("answers", "variables"))

  question_data["answers"].each do |answer_data|
    create_answer(answer_data, question)
  end
end

def create_section(section_data, chapter)
  puts "  - Creating section #{section_data['title']}"
  section = chapter.sections.create!(title: section_data["title"])

  section_data["questions"].each do |question_data|
    create_question(question_data, section)
  end
end

def create_chapter(chapter_data)
  puts "- Creating chapter #{chapter_data[:title]}"
  chapter = Chapter.create!(title: chapter_data[:title])

  chapter_data[:sections_data].each do |section_data|
    create_section(section_data, chapter)
  end
end

namespace :db do
  namespace :seed do
    desc "Wipes Course Content and feeds it with db/support yaml files"
    task course_content: :environment do
      yaml_file_paths = Dir.glob("db/support/*.yml")
      yaml_file_paths.each do |yaml_file_path|
        chapter_data = chapter_naming_data(yaml_file_path)
        create_chapter(chapter_data)
      end
    end
  end
end
