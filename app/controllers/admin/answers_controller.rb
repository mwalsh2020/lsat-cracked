class Admin::AnswersController < Admin::ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
    authorize @answer
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    authorize @answer

    if @answer.save
      redirect_to admin_questions_path
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :correct)
  end
end
