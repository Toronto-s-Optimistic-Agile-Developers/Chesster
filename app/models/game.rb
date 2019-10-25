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

  def first_turn!
    update(user_turn: 'white')
  end

  def turn_user_validation
    if (user_turn == 'white') && (self.white_id == self.player_id) && (self.pieces.where(color: 'white'))
      return 'white'
    elsif
      (user_turn == 'black') && (self.black_id == self.second_player_id) && (self.pieces.where(color: 'black'))
      return 'black'
    else
      return false
    end
  end

  def pass_turn!
    if (self.user_turn == 'white') 
      update(user_turn: 'black')
    elsif (self.user_turn == 'black')
      update(user_turn: 'white')
    end
  end

  def tile_taken?(x_path, y_path)
    pieces.where(x_coord: x_path, y_coord: y_path).first.present? 
  end 
  
  def in_check?(color)
    @rival_causing_check = []
    king = find_king(color)
    if king
      opponents = opponent_pieces(color)
      opponents.each do |piece|
        @rival_causing_check << piece if piece.valid_move?(king.x_coord, king.y_coord) == true
      end
    end
    return true if @rival_causing_check.any?
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

    #Kings
    King.create(game_id: id, color: "white", x_coord: 4, y_coord: 7, name: "White_King")


    King.create(game_id: id, color: "black", x_coord: 4, y_coord: 0, name: "Black_King")

    #Queens
    Queen.create(game_id: id, color: "white", x_coord: 3, y_coord: 7, name: "White_Queen")

    Queen.create(game_id: id, color: "black", x_coord: 3, y_coord: 0, name: "Black_Queen")
  
  def opponent_pieces(color)
    rival_color = if color == 'black'
      'white'
    else
      'black'
    end
    pieces.where(color: rival_color).to_a
  end

  def my_pieces(color)
    friendly_pieces = if color == 'black'
      'black'
    else
      'white'
    end
    pieces.where(color: friendly_pieces).to_a
  end

  end
end
