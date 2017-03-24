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

  # Update if a public post; or owned by this user; or user is 
  # part of the collaboration for this post
  # 
  
  def update?
    !record.private? || record.user_id == user.id || record.user_collaborators.include?(user)|| user.admin?
  end

  def destroy?
    record.user_id == user.id || user.admin?
  end
end #Post policy
