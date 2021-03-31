require "rails_helper"

RSpec.describe QuizQuestion::PerformanceQuery do
  describe ".new" do
    it "raises error unless given a question relation" do
      quiz_questions = QuizQuestion.none

      expect { described_class.new }.to raise_error(ArgumentError)
      expect { described_class.new([]) }.to raise_error(ArgumentError)
      expect { described_class.new(quiz_questions) }.to_not raise_error
    end
  end
end
