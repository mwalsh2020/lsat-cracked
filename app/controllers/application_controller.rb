class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller?
  end

  def current_user
    super || User::Guest.new
  end

  def referrer_params
    Rack::Utils.parse_query(request.referer.match(/\?(.*)/)&.to_a&.first)&.symbolize_keys
  end
end
