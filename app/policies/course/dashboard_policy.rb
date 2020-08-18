class Course::DashboardPolicy < ApplicationPolicy
  def show?
    user.admin? || user.paying?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
