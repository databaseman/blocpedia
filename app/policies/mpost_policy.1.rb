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

  # Show checkbox for private when user is admin or
  # user is premium and owner of the post

end #Post policy
