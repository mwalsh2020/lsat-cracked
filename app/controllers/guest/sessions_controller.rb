class Guest::SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @quizable = Article.where(intro: true).first
    @quiz = QuizBuilder.new(user: current_user, quizable: @quizable).build
    @quiz_session = Quiz::Session.new(quiz_session_params.merge(quiz: @quiz))
    @mail_lead = MailLead.new

    authorize [:guest, @quiz_session]
    render :show
  end

  private

  def quiz_session_params
    params.require(:quiz_session).permit(quiz_questions_attributes: [:id, :answer_id])
  end
end
