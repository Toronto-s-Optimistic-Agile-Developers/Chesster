class Game < Board < ApplicationRecord
  belongs_to :user
  has_many :pieces

  validates :name, presence: true

end
