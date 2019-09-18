class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games
<<<<<<< HEAD

=======
  extend FriendlyId
  friendly_id :username, use: :slugged
  validates :user, presence: true
>>>>>>> 6d0cfcb939150325807db57d6c09403f60bc8f89
  
end
