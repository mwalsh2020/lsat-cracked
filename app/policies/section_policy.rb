class SectionPolicy < ApplicationPolicy
  def show?
    # TODO: update to see only sections from free chapters if not paying
    user.admin? || record.chapter.free? || user.paying?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
