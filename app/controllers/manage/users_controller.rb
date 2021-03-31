class Manage::UsersController < Manage::ApplicationController
  def index
    @users = policy_scope([:manage, User])
  end

  def edit
    @user = User.find(params[:id])
    authorize [:manage, @user]
  end

  def update
    @user = User.find(params[:id])
    authorize [:manage, @user]

    if @user.update(user_params)
      redirect_to [:manage, :users]
    else
      render :edits
    end
  end

  private

  def user_params
    params.require(:user).permit(:paying, :prep_plus)
  end
end
