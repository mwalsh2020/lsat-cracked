require "rails_helper"

RSpec.describe QuizSessionBuilder, type: :model do
  it "implements #user=" do
    quiz_session_builder = QuizSessionBuilder.new
    user = User.new

    expect(quiz_session_builder).to receive(:user=).with(user)

    quiz_session_builder.user = user
  end

  it "implements #section=" do
    quiz_session_builder = QuizSessionBuilder.new
    section = Section.new

    expect(quiz_session_builder).to receive(:section=).with(section)

    quiz_session_builder.section = section
  end

  describe "#build" do
    context "user has a pending quiz for given section" do
      it "returns pending quiz session" do
        section = Section.new
        user = User.new

        quiz_session = QuizSession.new
        allow(user).to receive(:pending_quiz).with(section) { quiz_session }

        quiz_session_builder = QuizSessionBuilder.new
        quiz_session_builder.user = user
        quiz_session_builder.section = section

        expect(quiz_session_builder.build).to eq(quiz_session)
      end
    end
  end
end
