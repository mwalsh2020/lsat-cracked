class CoachingRequestsController < ApplicationController
  def new; end

  def create
    WebMailer.with(coaching_request_params).coaching.deliver_now

    flash[:notice] = "Mail sent successfully!"
    redirect_to coaching_path
  end

  private

  def coaching_request_params
    params.required(:coaching_contact).permit(:name, :email, :target_law_school, :target_lsat_score, :message)
  end
end
