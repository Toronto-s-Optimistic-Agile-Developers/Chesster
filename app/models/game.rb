<<<<<<< HEAD
# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :white_id, class_name: 'User', optional: true
  belongs_to :black_id, class_name: 'User', optional: true

  has_many :pieces

  scope :available, -> { where(black_id: nil) }

  def available?
    black_id.blank?
  end
  
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

    #King
    King.create(game_id: id, color: "white", x_coord: 4, y_coord: 7, name: "White_King")

    King.create(game_id: id, color: "black", x_coord: 4, y_coord: 0, name: "Black_King")

    #Queen
    Queen.create(game_id: id, color: "white", x_coord: 3, y_coord: 7, name: "White_Queen")

    Queen.create(game_id: id, color: "black", x_coord: 3, y_coord: 0, name: "Black_Queen")
  end
end
=======
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
  
  #validates :name, presence: true
  def set_up_board!
  # Pawns
    (1..8).each do |x_coord|
      Pawn.create(game_id: id, color: white, x_coord: x_coord, y_coord: 6, user_id: white_id, name: "White_Pawn", image: "&#9817;")
    end

    (1..8).each do |x_coord|
      Pawn.create(game_id: id, color: black, x_coord: x_coord, y_coord: 1, user_id: black_id, name: "Black_Pawn", image: "&#9823;")
    end

    # Rooks
    [1, 8].each do |x_coord|
      Rook.create(game_id: id, color: white, x_coord: x_coord, y_coord: 7, user_id: white_id, name: "White_Rook", image: "&#9814;")
    end

    [1, 8].each do |x_coord|
      Rook.create(game_id: id, color: black, x_coord: x_coord, y_coord: 0, user_id: black_id, name: "Black_Rook", image: "&#9820;")
    end

    # Knights
    [2, 7].each do |x_coord|
      Knight.create(game_id: id, color: white, x_coord: x_coord, y_coord: 7, user_id: white_id, name: "White_Knight", image: "&#9816;")
    end

    [2, 7].each do |x_coord|
      Knight.create(game_id: id, color: black, x_coord: x_coord, y_coord: 0, user_id: black_id, name: "Black_Knight", image: "&#9822;")
    end

    #Bishops
    [3, 6].each do |x_coord|
      Bishop.create(game_id: id, color: white, x_coord: x_coord, y_coord: 7, user_id: white_id, name: "White_Bishop", image: "&#9815;")
    end

    [3, 6].each do |x_coord|
      Bishop.create(game_id: id, color: black, x_coord: x_coord, y_coord: 0, user_id: black_id, name: "Black_Bishop", image: "&#9821;")
    end

    #King
    King.create(game_id: id, color: white, x_coord: 4, y_coord: 7, user_id: white_id, name: "White_King", image: "&#x2654;")

    King.create(game_id: id, color: black, x_coord: 4, y_coord: 0, user_id: black_id, name: "Black_King", image: "&#9818;")

    #Queen
    Queen.create(game_id: id, color: white, x_coord: 3, y_coord: 7, user_id: white_id, name: "White_Queen", image: "&#9813;")

    Queen.create(game_id: id, color: black, x_coord: 3, y_coord: 0, user_id: black_id, name: "Black_Queen", image: "&#9819;")
  end
end
>>>>>>> 4c4dda23982dc1e51239b4eea9346c9ab49afc5a
