class Post < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :user_collaborators, through: :collaborators, source: :user
  default_scope { order(updated_at: :desc) }
end
