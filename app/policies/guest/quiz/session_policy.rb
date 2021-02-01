class Guest::Quiz::SessionPolicy < ApplicationPolicy
  def create?
    true
  end
end
