require "rails_helper"

RSpec.describe QuizBuilder, type: :model do
  let(:quiz_builder) { QuizBuilder.new }
  let(:section)              { Section.new }
  let(:user)                 { User.new }

  it { expect(quiz_builder).to respond_to(:user=) }
  it { expect(quiz_builder).to respond_to(:section=) }

  describe "#build" do
    context "user has NO quiz for given section" do
      before do
        allow(user).to receive(:last_quiz_for).with(section) { nil }
        quiz_builder.user = user
        quiz_builder.section = section
      end

      it "returns a new quiz" do
        expect(quiz_builder.build).to be_a(Quiz)
        expect(quiz_builder.build).to_not be_persisted
      end
    end

    context "user has A PENDING quiz for given section" do
      let(:quiz) { Quiz.new }

      before do
        allow(user).to receive(:last_quiz_for).with(section) { quiz }
      end

      it "returns pending quiz session" do
        quiz_builder.user = user
        quiz_builder.section = section

        expect(quiz_builder.build).to eq(quiz)
      end
    end
  end
end
