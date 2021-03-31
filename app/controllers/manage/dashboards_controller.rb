class Manage::DashboardsController < ApplicationController
  def show
    authorize [:manage, :dashboard]

    redirect_to [:manage, :chapters]
  end
end
