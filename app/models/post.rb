class Post < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :user_collaborators, through: :collaborators, source: :user
end
