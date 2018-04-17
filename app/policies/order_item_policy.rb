class OrderItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def destroy?
    true
  end
end
