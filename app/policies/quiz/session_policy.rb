class Quiz::SessionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    if record.premium?
      quiz_owner? && user.paying?
    else
      quiz_owner?
    end
  end

  private

  def quiz_owner?
    record.user == user
  end
end
