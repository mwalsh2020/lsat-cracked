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
      scope.order(position: :asc)
    end
  end
end
