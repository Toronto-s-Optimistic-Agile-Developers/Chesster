# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :white_id, class_name: 'User'
  belongs_to :black_id, class_name: 'User', optional: true

  has_many :pieces

  scope :available, -> { where(black_id: nil) }

  def available?
    black_id.blank?
  end
  
  validates :name, presence: true
  def set_up_board!
  # Pawns
    (1..8).each do |x_coord|
      Pawn.create(game: self, color: "white", x_coord: x_coord, y_coord: 6, white_id: user_id, name: "White_Pawn", image: "&#9817;", player_id: user_id)
    end

    (1..8).each do |x_coord|
      Pawn.create(game: self, color: "black", x_coord: x_coord, y_coord: 1, black_id: user_id, name: "Black_Pawn", image: "&#9823;", player_id: user_id)
    end

    # Rooks
    [1, 8].each do |x_coord|
      Rook.create(game: self, color: "white", x_coord: x_coord, y_coord: 7, white_id: user_id, name: "White_Rook", image: "&#9814;", player_id: user_id)
    end

    [1, 8].each do |x_coord|
      Rook.create(game: self, color: "black", x_coord: x_coord, y_coord: 0, black_id: user_id, name: "Black_Rook", image: "&#9820;", player_id: user_id)
    end

    # Knights
    [2, 7].each do |x_coord|
      Knight.create(game: self, color: "white", x_coord: x_coord, y_coord: 7, white_id: user_id, name: "White_Knight", image: "&#9816;", player_id: user_id)
    end

    [2, 7].each do |x_coord|
      @game.Knight.create(game: self, color: "black", x_coord: x_coord, y_coord: 0, black_id:user_id, name: "Black_Knight", image: "&#9822;", player_id: user_id)
    end

    #Bishops
    [3, 6].each do |x_coord|
      Bishop.create(game: self, color: "white", x_coord: x_coord, y_coord: 7, white_id: user_id, name: "White_Bishop", image: "&#9815;", player_id: user_id)
    end

    [3, 6].each do |x_coord|
      Bishop.create(game: self, color: "black", x_coord: x_coord, y_coord: 0, black_id: user_id, name: "Black_Bishop", image: "&#9821;", player_id: user_id)
    end

    #King
    King.create(game: self, color: "white", x_coord: 4, y_coord: 7, white_id: user_id, name: "White_King", image: "&#x2654;", player_id: user_id)

    King.create(game: self, color: "black", x_coord: 4, y_coord: 0, black_id: user_id, name: "Black_King", image: "&#9818;", player_id: user_id)

    #Queen
    Queen.create(game: self, color: "white", x_coord: 3, y_coord: 7, white_id: user_id, name: "White_Queen", image: "&#9813;", player_id: user_id)

    Queen.create(game: self, color: "black", x_coord: 3, y_coord: 0, black_id: user_id, name: "Black_Queen", image: "&#9819;", player_id: user_id)
  end
end
