class Admin::DashboardsController < ApplicationController
  def show
    authorize [:admin, :dashboard]

    redirect_to [:admin, :chapters]
  end
end
