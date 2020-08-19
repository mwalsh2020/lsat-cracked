require "rails_helper"

RSpec.describe QuizBuilder, type: :model do
  let(:quiz_builder) { QuizBuilder.new }
  let(:section)              { Section.new }
  let(:user)                 { User.new }

  it { expect(quiz_builder).to respond_to(:user=) }
  it { expect(quiz_builder).to respond_to(:section=) }

  describe "#build" do
    context "user has NO PENDING quiz for given section" do
      before do
        allow(user).to receive(:pending_quiz).with(section) { nil }
      end

      it "returns a new quiz session" do
        quiz_builder.user = user
        quiz_builder.section = section

        expect(quiz_builder.build).to be_a(Quiz)
        expect(quiz_builder.build).to_not be_persisted
      end
    end

    context "user has A PENDING quiz for given section" do
      let(:quiz) { Quiz.new }

      before do
        allow(user).to receive(:pending_quiz).with(section) { quiz }
      end

      it "returns pending quiz session" do
        quiz_builder.user = user
        quiz_builder.section = section

        expect(quiz_builder.build).to eq(quiz)
      end
    end
  end
end
