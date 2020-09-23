class Admin::QuestionsController < Admin::ApplicationController
  def new
    @section  = Section.find(params[:section_id])
    @question = Question.new
    authorize @question
  end

  def create
    @section  = Section.find(params[:section_id])
    @question = Question.new(question_params)
    authorize @question

    if @section.add_question(@question)
      redirect_to [:admin, @section, :questions]
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
      redirect_to [:admin, :questions]
    else
      render :edit
    end
  end

  def index
    @questions = policy_scope(Question.with_questions_and_answers)
  end

  def destroy
    @question = Question.find(params[:id])
    authorize @question

    @question.destroy
    redirect_to [:admin, @question.section, :questions]
  end

  private

  def question_params
    params.require(:question).permit(:prompt, :explanation, article_ids: [], section_ids: [], tag_ids: [])
  end
end
