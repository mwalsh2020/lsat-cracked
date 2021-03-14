class Manage::DashboardsController < ApplicationController
  def show
    authorize [:manage, :dashboard]

    redirect_to [:admin, :chapters]
  end
end
