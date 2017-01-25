class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where( "private=0 OR user_id=?", user.id )
        debugger
      end
    end
  end

  def private?
    user.admin? or user.premium?
  end

end
