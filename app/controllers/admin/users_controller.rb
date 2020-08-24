class Admin::UsersController < Admin::ApplicationController
  def index
    @users = policy_scope([:admin, User])
  end
end
