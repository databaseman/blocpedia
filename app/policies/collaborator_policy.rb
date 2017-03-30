class CollaboratorPolicy < ApplicationPolicy
  attr_reader :user, :post

  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    (post.user_id == user.id) || user.admin?
  end

  def destroy?
    show?
  end
end
