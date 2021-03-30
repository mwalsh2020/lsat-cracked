require "rails_helper"

RSpec.describe Query::QuestionsTagData do
  describe ".new" do
    it "accepts a question relation" do
      questions = Question.all

      expect { described_class.new(questions) }.to_not raise_error
    end
  end
end
