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
    update(user_turn: 'white_id')
  end

  def pass_turn!(color)
    player_turn = color == 'white_id' ? 'black_id' : 'white_id'
    update(user_turn: player_turn)
  end

  def tile_taken?(x_path, y_path)
    pieces.where(x_coord: x_path, y_coord: y_path).first.present? 
  end 
  
  def in_check?(color)
    king_black = Piece.find_by(game_id: self.game_id, name: 'White_King', x_coord: x_coord, y_coord: y_coord, color: color)
    king_white = Piece.find_by(game_id: self.game_id, name: 'Black_King', x_coord: x_coord, y_coord: y_coord, color: color)
      if king_black
        rival_piece = Piece.find_by(x_coord: x_path, y_coord: y_path, game_id: self.game_id, color: !color)
        rival_piece.each do |piece|
          if piece.valid_move?(x_coord: king_black.x_coord, y_coord: king_black.y_coord)
            rival_causing_check = piece
          return true
          end
        end
      elsif king_white
        rival_piece = Piece.find_by(x_coord: x_path, y_coord: y_path, game_id: self.game_id, color: !color)
        rival_piece.each do |piece|
          if piece.valid_move?(x_coord: king_white.x_coord, y_coord: king_white.y_coord)
            rival_causing_check = piece
          return true
          end
        end
      end
      false
  end
  
     
          
  #validates :name, presence: true
  def set_up_board!
  # Pawns
    (0..7).each do |x_coord|
      Pawn.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 6, name: "White_Pawn", title: "Pawn")
    end

    (0..7).each do |x_coord|
      Pawn.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 1, name: "Black_Pawn", title: "Pawn" )
    end

    # Rooks
    [0, 7].each do |x_coord|
      Rook.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7,  name: "White_Rook", title: "Rook")
    end

    [0, 7].each do |x_coord|
      Rook.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, name: "Black_Rook", title: "Rook")
    end

    # Knights
    [1, 6].each do |x_coord|
      Knight.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7, name: "White_Knight", title: "Knight")
    end

    [1, 6].each do |x_coord|
      Knight.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, name: "Black_Knight",  title: "Knight")
    end

    #Bishops
    [2, 5].each do |x_coord|
      Bishop.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7, name: "White_Bishop", title: "Bishop")
    end

    [2, 5].each do |x_coord|
      Bishop.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, name: "Black_Bishop", title: "Bishop")
    end

    #Kings
    King.create(game_id: id, color: "white", x_coord: 4, y_coord: 7, name: "White_King", title: "King")


    King.create(game_id: id, color: "black", x_coord: 4, y_coord: 0, name: "Black_King", title: "King")

    #Queens
    Queen.create(game_id: id, color: "white", x_coord: 3, y_coord: 7, name: "White_Queen",  title: "Queen")

    Queen.create(game_id: id, color: "black", x_coord: 3, y_coord: 0,  name: "Black_Queen",  title: "Queen")
  end
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

