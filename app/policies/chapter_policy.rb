class ChapterPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  # TODO: update this, makes no sense
  def show?
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
      if user.paying?
        scope.order(position: :asc)
      else
        scope.where(free: true)
      end
    end
  end
end
