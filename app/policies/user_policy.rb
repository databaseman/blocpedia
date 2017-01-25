class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def premium?
    user.admin? or user.premium?
  end

end
