class Game < ApplicationRecord
  belongs_to :user
  has_many :peices
  validates :username, presence: true, length: { minimum: 4, maximun: 10 }

end
