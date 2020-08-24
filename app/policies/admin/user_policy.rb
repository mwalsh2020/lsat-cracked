class Admin::UserPolicy < ApplicationPolicy
  def update?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
