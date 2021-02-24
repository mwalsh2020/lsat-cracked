# set to false for merge until UI is determined

class Guest::Quiz::SessionPolicy < ApplicationPolicy
  def create?
    true
  end
end
