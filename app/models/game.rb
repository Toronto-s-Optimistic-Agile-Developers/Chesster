# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :white_id, class_name: 'User'
  belongs_to :black_id, class_name: 'User', optional: true
  has_many :pieces

  scope :available, -> { where(black_id: nil). or where (white_id: nil) }

  def available?
    black_id.blank?
  end
  
  validates :name, presence: true
end
