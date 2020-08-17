class Admin::QuestionsController < Admin::ApplicationController
  def new
    @section  = Section.find(params[:section_id])
    @question = Question.new
    authorize @question
  end

  def create
    @section  = Section.find(params[:section_id])
    @question = Question.new(question_params)
    @question.section = @section
    authorize @question

    if @question.save
      redirect_to [:admin, @question.section, :questions]
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
    authorize @question
  end

  def update
    @question = Question.find(params[:id])
    authorize @question

    if @question.update(question_params)
      redirect_to [:admin, @question.section, :questions]
    else
      render :edit
    end
  end

  def index
    @section  = Section.find(params[:section_id])
    @questions = policy_scope(@section.questions)
  end

  def destroy
    @question = Question.find(params[:id])
    authorize @question

    @question.destroy
    redirect_to [:admin, @question.section, :questions]
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end
