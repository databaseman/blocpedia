class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  validates :name,  presence: true, length: { maximum: 50 }
  has_many :posts, dependent: :destroy
  before_save { self.role ||= :standard }

  enum role: [:standard, :premium, :admin]

end
