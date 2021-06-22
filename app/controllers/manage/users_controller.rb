class Manage::UsersController < Manage::ApplicationController
  def create
    # Create the user from params
    @user = User.new(user_params)
    if @user.save
      # Deliver the signup email
      UserNotifierMailer.send_signup_email(@user).deliver
      redirect_to(@user, :notice => 'User created')
    else
      render :action => 'new'
    end
  end

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
