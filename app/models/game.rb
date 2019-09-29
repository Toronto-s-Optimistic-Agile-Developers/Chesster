# frozen_string_literal: true

class Game < ApplicationRecord
<<<<<<< HEAD
  belongs_to :white_id, class_name: 'User', optional: true
  belongs_to :black_id, class_name: 'User', optional: true

  has_many :pieces

  scope :available, -> { where(black_id: nil) }

  def available?
    black_id.blank?
  end

  def tile_taken?(x_path, y_path)
    pieces.where(x_coord: x_path, y_coord: y_path).first.present? 
  end 
=======
  belongs_to :white_player, class_name: 'User', optional: true
  belongs_to :black_player, class_name: 'User', optional: true

  has_many :pieces
  has_many :users
  
  scope :available, -> { where(black_player: nil) }

  def unmatched_games
    Game.where(black_player: nil) && Game.where(white_player: !nil)
  end
>>>>>>> f1d37445f8ec89cf30881bc21942ee2a9fc4d320
  
  #validates :name, presence: true
  def set_up_board!
  # Pawns
    (0..7).each do |x_coord|
      Pawn.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 6, name: "White_Pawn")
    end

    (0..7).each do |x_coord|
      Pawn.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 1, name: "Black_Pawn")
    end

    # Rooks
    [0, 7].each do |x_coord|
      Rook.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7,  name: "White_Rook")
    end

    [0, 7].each do |x_coord|
      Rook.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, name: "Black_Rook")
    end

    # Knights
    [1, 6].each do |x_coord|
      Knight.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7, name: "White_Knight")
    end

    [1, 6].each do |x_coord|
      Knight.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, name: "Black_Knight")
    end

    #Bishops
    [2, 5].each do |x_coord|
      Bishop.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7, name: "White_Bishop")
    end

    [2, 5].each do |x_coord|
      Bishop.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, name: "Black_Bishop")
    end

<<<<<<< HEAD
    #Kings
=======
    #King
>>>>>>> f1d37445f8ec89cf30881bc21942ee2a9fc4d320
    King.create(game_id: id, color: "white", x_coord: 4, y_coord: 7, name: "White_King")

    King.create(game_id: id, color: "black", x_coord: 4, y_coord: 0, name: "Black_King")

<<<<<<< HEAD
    #Queens
=======
    #Queen
>>>>>>> f1d37445f8ec89cf30881bc21942ee2a9fc4d320
    Queen.create(game_id: id, color: "white", x_coord: 3, y_coord: 7, name: "White_Queen")

    Queen.create(game_id: id, color: "black", x_coord: 3, y_coord: 0, name: "Black_Queen")
  end
end
