class Admin::QuestionsController < Admin::ApplicationController
  before_action :set_section, only: [:new, :create, :update, :destroy]

  def new
    @question = Question.new(sections: [@section])
    authorize @question
  end

  def create
    @question = Question.new(question_params)
    authorize @question
    if @question.save
      redirect_to admin_questions_path(section_id: @section.id)
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
      redirect_to admin_questions_path(section_id: @section.id)
    else
      render :edit
    end
  end

  def index
    @questions = policy_scope(Question.with_questions_and_answers)
    filter_by_quizable if quizable_present?
  end

  def destroy
    @question = Question.find(params[:id])
    authorize @question

    @question.destroy
    redirect_to admin_questions_path(section_id: @section.id)
  end

  private

  def set_section
    @section = Section.find_or_initialize_by(id: referrer_params[:section_id])
  end

  def filter_by_quizable
    @section = Section.find(params[:section_id])
    @questions = @questions.where_quizable(@section)
  end

  def quizable_present?
    params[:section_id].present?
  end

  def question_params
    params.require(:question).permit(:prompt, :explanation, article_ids: [], section_ids: [], tag_ids: [])
  end
end
