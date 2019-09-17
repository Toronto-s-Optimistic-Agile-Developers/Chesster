class Game < ApplicationRecord
  belongs_to :user
  has_many :peices

  validates :name, presence: true

end
