require "rails_helper"

RSpec.describe QuizSessionBuilder, type: :model do
  let(:quiz_session_builder) { QuizSessionBuilder.new }
  let(:section)              { Section.new }
  let(:user)                 { User.new }

  it "implements #user=" do
    expect(quiz_session_builder).to receive(:user=).with(user)
    quiz_session_builder.user = user
  end

  it "implements #section=" do
    expect(quiz_session_builder).to receive(:section=).with(section)
    quiz_session_builder.section = section
  end

  describe "#build" do
    context "user has a pending quiz for given section" do
      before do
        allow(user).to receive(:pending_quiz).with(section) { nil }
      end

      it "returns a new quiz session" do
        quiz_session_builder.user = user
        quiz_session_builder.section = section

        expect(quiz_session_builder.build).to be_a(QuizSession)
        expect(quiz_session_builder.build).to_not be_persisted
      end
    end

    context "user has a pending quiz for given section" do
      let(:quiz_session) { QuizSession.new }

      before do
        allow(user).to receive(:pending_quiz).with(section) { quiz_session }
      end

      it "returns pending quiz session" do
        quiz_session_builder.user = user
        quiz_session_builder.section = section

        expect(quiz_session_builder.build).to eq(quiz_session)
      end
    end
  end
end
