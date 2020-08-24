class Admin::UsersController < Admin::ApplicationController
  def index
    @users = policy_scope([:admin, User])
  end

  def edit
    @user = User.find(params[:id])
    authorize [:admin, @user]
  end
end
