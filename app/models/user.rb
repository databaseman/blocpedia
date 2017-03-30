class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :name,  presence: true, length: { maximum: 50 }
  has_many :posts, dependent: :destroy
  has_many :collaborators
  has_many :post_collaborators, through: :collaborators, source: :post
  before_save { self.role ||= :standard }
  default_scope { order(email: :asc) }
  
  enum role: [:standard, :premium, :admin]

end
