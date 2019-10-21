# frozen_string_literal: true

class Game < ApplicationRecord

  belongs_to :white_player, class_name: 'User', optional: true
  belongs_to :black_player, class_name: 'User', optional: true

  has_many :pieces
  has_many :users
  
  scope :available, -> { where(black_player: nil) }

  def unmatched_games
    Game.where(black_player: nil) && Game.where(white_player: !nil)
  end
  
  def in_play?
    self.white_id != nil && self.black_id != nil
  end

  def tile_taken?(x_path, y_path)
    pieces.where(x_coord: x_path, y_coord: y_path).first.present? 
  end 
  
  #validates :name, presence: true
  def set_up_board!
  # Pawns
    (0..7).each do |x_coord|
      Pawn.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 6, name: "White Pawn", promotion_type: nil)
    end

    (0..7).each do |x_coord|
      Pawn.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 1, name: "Black Pawn", promotion_type: nil)
    end

    # Rooks
    [0, 7].each do |x_coord|
      Rook.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7,  name: "White Rook")
    end

    [0, 7].each do |x_coord|
      Rook.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, name: "Black Rook")
    end

    # Knights
    [1, 6].each do |x_coord|
      Knight.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7, name: "White Knight")
    end

    [1, 6].each do |x_coord|
      Knight.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, name: "Black Knight")
    end

    #Bishops
    [2, 5].each do |x_coord|
      Bishop.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7, name: "White Bishop")
    end

    [2, 5].each do |x_coord|
      Bishop.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, name: "Black Bishop")
    end

    #Kings
    King.create(game_id: id, color: "white", x_coord: 4, y_coord: 7, name: "White King")

    King.create(game_id: id, color: "black", x_coord: 4, y_coord: 0, name: "Black King")

    #Queens
    Queen.create(game_id: id, color: "white", x_coord: 3, y_coord: 7, name: "White Queen")

    Queen.create(game_id: id, color: "black", x_coord: 3, y_coord: 0, name: "Black Queen")
  end
end
