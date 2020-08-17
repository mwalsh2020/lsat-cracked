class CoachingRequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :skip_authorization, only: [:new, :create]

  def new
    @coaching_request = CoachingRequest.new
  end

  def create
    @coaching_request = CoachingRequest.new(coaching_request_params)
    if @coaching_request.submit
      flash[:notice] = "Mail sent successfully!"
      redirect_to new_coaching_request_path
    else
      render :new
    end
  end

  private

  def coaching_request_params
    params.required(:coaching_request).permit(:name, :email, :target_law_school, :target_lsat_score, :message)
  end
end
