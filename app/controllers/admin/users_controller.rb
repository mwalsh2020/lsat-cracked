class Admin::UsersController < Admin::ApplicationController
  def index
    @users = policy_scope([:admin, User])
  end

  def edit
    @user = User.find(params[:id])
    authorize [:admin, @user]
  end

  def update
    @user = User.find(params[:id])
    authorize [:admin, @user]

    if @user.update(user_params)
      redirect_to [:admin, :users]
    else
      render :edits
    end
  end

  private

  def user_params
    params.require(:user).permit(:paying)
  end
end
