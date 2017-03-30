class PostPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      posts = []
      all_posts = scope.all
      if user.admin?
        posts = scope.all
      elsif user.premium?
        all_posts.each do |post|
          if !post.private? || post.user_id == user.id || post.user_collaborators.include?(user)
            posts << post
          end
        end
      else # standard user
        all_posts.each do |post|
          if !post.private? || post.user_collaborators.include?(user)
            posts << post
          end
        end
      end
      posts
    end #resolve

  end #Scope

  def edit?
    update?
  end

  # Update if a public post; or owned by this user; or user is
  # part of the collaboration for this post; or an admin
  def update?
    !record.private? || record.user_id == user.id || record.user_collaborators.include?(user)|| user.admin?
  end

  # Only if owner or admin
  def destroy?
    record.user_id == user.id || user.admin?
  end

  # Same as update
  def show?
    update?
  end

  # Allow managing collaboration on private post only, and user must be owner or admin
  def collaborate?
    record.private? && (record.user_id == user.id || user.admin?)
  end

  # Can make toggle post privacy if current user is the owner or admin
  def checkbox?
     ( record.user_id == user.id ) || user.admin?
  end

end #Post policy
