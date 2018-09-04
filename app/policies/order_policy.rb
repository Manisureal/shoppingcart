class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def index?
    unless user.admin || user.sales
      return true
    end
  end

  def show?
    if user.admin || user.sales
      return false
    else
      if self.user == user
        return true
      end
    end
  end

  def create?
    unless user.admin || user.sales
      return true
    end
  end

  def new?
    unless user.admin || user.sales
      return true
    end
  end

  def edit?
    if user.admin || user.sales
      return false
    else
      if self.user == user
        return true
      end
    end
  end

  def update?
    if user.admin || user.sales
      return false
    else
      if self.user == user
        return true
      end
    end
  end

  def order_again?
    if user.admin || user.sales
      return false
    else
      if self.user == user
        return true
      end
    end
  end

end
