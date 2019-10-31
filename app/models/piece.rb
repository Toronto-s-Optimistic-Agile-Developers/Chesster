class Piece < ApplicationRecord
  attr_accessor :rival_piece
  belongs_to :game
  belongs_to :user, required: false

  after_create_commit {
    PieceBroadcastJob.perform_later(self)
  }
  
  def white?
    piece.color == 'white'
  end

  def black?
    !white?
  end

  def removed?
    update(captured: true, x_coord: nil, y_coord: nil)
  end

  def has_moved?
    if self.initial_position? == true
      return false
    else
      return true
    end
  end

  def friendly_piece(x_path, y_path)
    return true if self.game.tile_taken?(x_path, y_path) && self.color == self.game.pieces.where(x_coord: x_path, y_coord: y_path).first.color
    return false if self.type == "Knight"
  end

  def on_the_board?(x_path, y_path)
    if y_path < 0 || y_path > 7 
      return false
    elsif x_path < 0 || x_path > 7
      return false
    else
      return true
    end
  end 

   def diagonal_move?(x_path, y_path)
    x_path == y_path
  end

  private def add(arr1, arr2)
    [arr1[0] + arr2[0], arr1[1] + arr2[1]]
  end

  def in_check?(color)
    @king_black = Piece.find_by(game_id: self.game_id, name: 'White_King', x_coord: x_coord, y_coord: y_coord)
    @king_white = Piece.find_by(game_id: self.game_id, name: 'Black_King', x_coord: x_coord, y_coord: y_coord)
      if @king_black
        rival_piece = Piece.find_by(x_coord: x_path, y_coord: y_path, game_id: self.game_id)
        rival_piece.each do |piece|
          if piece.valid_move?(x_coord: @king_black.x_coord, y_coord: @king_black.y_coord)
            rival_causing_check = piece
          return true
          end
        end
      elsif @king_white
        rival_piece = Piece.find_by(x_coord: x_path, y_coord: y_path, game_id: self.game_id)
        rival_piece.each do |piece|
          if piece.valid_move?(x_coord: @king_white.x_coord, y_coord: @king_white.y_coord)
            rival_causing_check = piece
          return true
          end
        end
      end
      false
  end

  def is_obstructed?(x_path, y_path) 
    return true if self.game.tile_taken?(x_path, y_path) && self.color == self.game.pieces.where(x_coord: x_path, y_coord: y_path).first.color
    return false if (self.type == "Knight")
    x_dir = x_path >= self.x_coord ? (x_path == self.x_coord ? 0 : 1) : -1
    y_dir = y_path >= self.y_coord ? (y_path == self.y_coord ? 0 : 1) : -1
    direction = [x_dir, y_dir]
    location = add(direction, [self.x_coord, self.y_coord])
    while location != [x_path, y_path]
      return true if self.game.tile_taken?(location[0], location[1])
      location = add(direction, location)
    end
    false
  end
  
  def check_black_nil_spaces_for_castling
    Piece.find_by(game_id: self.game_id, x_coord: 1, y_coord: 0) == nil && 
    Piece.find_by(game_id: self.game_id, x_coord: 2, y_coord: 0) == nil && Piece.find_by(game_id: self.game_id, x_coord: 3, y_coord: 0) == nil && 
    Piece.find_by(game_id: self.game_id, x_coord: 5, y_coord: 0) == nil && Piece.find_by(game_id: self.game_id, x_coord: 6, y_coord: 0) == nil
  end
 
  def check_white_nil_spaces_for_castling
    Piece.find_by(game_id: self.game_id, x_coord: 1, y_coord: 7) == nil && 
    Piece.find_by(game_id: self.game_id, x_coord: 2, y_coord: 7) == nil && Piece.find_by(game_id: self.game_id, x_coord: 3, y_coord: 7) == nil && 
    Piece.find_by(game_id: self.game_id, x_coord: 5, y_coord: 7) == nil && Piece.find_by(game_id: self.game_id, x_coord: 6, y_coord: 7) == nil
  end

  def black_left_castle(x_path, y_path)
    king_black = Piece.find_by(game_id: self.game_id, x_coord: 4, y_coord: 0)
    left_rook_black = Piece.find_by(game_id: self.game_id, x_coord: 0, y_coord: 0)
    if (king_black.initial_position? == true && left_rook_black.initial_position? == true)
      if ((left_rook_black.x_coord == 0) || (king_black.x_coord == 4 )) && self.check_black_nil_spaces_for_castling 
        King.create(game_id: self.game_id, color: left_rook_black.color, x_coord: 2, y_coord: 0, initial_position?: false, name: "Castled_King", title: "King")
        Rook.create(game_id: self.game_id, color: king_black.color, x_coord: 3, y_coord: 0, initial_position?: false, name: "Castled_Rook", title: "Rook")
        king_black.destroy
        left_rook_black.destroy
        return true
      end
    end
    return false
  end

    def black_right_castle(x_path, y_path)
      king_black = Piece.find_by(game_id: self.game_id, x_coord: 4, y_coord: 0)
      right_rook_black = Piece.find_by(game_id: self.game_id, x_coord: 7, y_coord: 0)
      if (king_black.initial_position? == true && right_rook_black.initial_position? == true)
        if (right_rook_black.x_coord == 7) || (king_black.x_coord == 4) && self.check_black_nil_spaces_for_castling 
          King.create(game_id: self.game_id, color: right_rook_black.color, x_coord: 6, y_coord: 0, initial_position?: false, name: "Castled_King", title: "King")
          Rook.create(game_id: self.game_id, color: king_black.color, x_coord: 5, y_coord: 0, initial_position?: false, name: "Castled_Rook", title: "Rook")
          king_black.destroy
          right_rook_black.destroy
          return true
        end
      end
      return false
    end
    def white_left_castle(x_path, y_path)
      king_white = Piece.find_by(game_id: self.game_id, x_coord: 4, y_coord: 7)
      left_rook_white = Piece.find_by(game_id: self.game_id, x_coord: 0, y_coord: 7)
      if (king_white.initial_position? == true && left_rook_white.initial_position? == true)
        if (left_rook_white.x_coord == 0) || (king_white.x_coord == 4) && self.check_white_nil_spaces_for_castling  
          King.create(game_id: self.game_id, color: left_rook_white.color, x_coord: 2, y_coord: 7, initial_position?: false, name: "Castled_King", title: "King")
          Rook.create(game_id: self.game_id, color: king_white.color, x_coord: 3, y_coord: 7, initial_position?: false, name: "Castled_Rook", title: "Rook")
          king_white.destroy
          left_rook_white.destroy
          return true
        end
      end
      return false
    end
    def white_right_castle(x_path, y_path)
      king_white = Piece.find_by(game_id: self.game_id, x_coord: 4, y_coord: 7)
      right_rook_white = Piece.find_by(game_id: self.game_id, x_coord: 7, y_coord: 7)
      if (king_white.initial_position? == true && right_rook_white.initial_position? == true)
        if (right_rook_white.x_coord == 7) || (king_white.x_coord == 4) && self.check_white_nil_spaces_for_castling 
          King.create(game_id: self.game_id, color: right_rook_white.color, x_coord: 6, y_coord: 7, initial_position?: false, name: "Castled_King", title: "King")
          Rook.create(game_id: self.game_id, color: king_white.color, x_coord: 5, y_coord:  7, initial_position?: false, name: "Castled_Rook", title: "Rook")
          king_white.destroy
          right_rook_white.destroy
          return true
        end
      end
      return false
    end

  def move_to!(x_path, y_path)
    rival_piece = Piece.find_by(x_coord: x_path, y_coord: y_path, game_id: self.game_id)
    if ! is_obstructed?(x_path, y_path)
      if rival_piece.present? && rival_piece.color != self.color
        ((x_path == 1) && (y_path == 1))
        rival_piece.removed?
        update_attributes(x_coord: x_path, y_coord: y_path)
      elsif rival_piece.present? == false
        update_attributes(x_coord: x_path, y_coord: y_path)
      end
    end
  end

  def valid_move?(x_path, y_path)
    if on_the_board?(x_path, y_path) && ! ((x_coord == x_path) && (y_coord == y_path) && ! friendly_piece(x_path, y_path))
      if legal_move?(x_path, y_path) && ! is_obstructed?(x_path, y_path)
        return true
        game.pass_turn!(game.user_turn)
      else
        return false
      end
    end
  end

  def pawn_promote(new_rank)
    case new_rank.downcase
    when 'rook'
      Rook.create(x_coord: self.x_coord, y_coord: self.y_coord, initial_position?: false, color: self.color, game_id: self.game_id, name: "Former_Pawn", title: "Pormoted Rook")
    when 'queen'
      Queen.create(x_coord: self.x_coord, y_coord: self.y_coord, initial_position?: false, color: self.color, game_id: self.game_id, name: "Former_Pawn", title: "Pormoted Queen")
    when 'bishop'
      Bishop.create(x_coord: self.x_coord, y_coord: self.y_coord, initial_position?: false, color: self.color, game_id: self.game_id, name: "Former_Pawn", title: "Pormoted Bishop")
    when 'knight'
      Knight.create(x_coord: self.x_coord, y_coord: self.y_coord, initial_position?: false, color: self.color, game_id: self.game_id, name: "Former_Pawn", title: "Pormoted Knight")
    end
    self.destroy
  end

  RANK = {
    'Knight': 'Knight',
    'Bishop': 'Bishop',
    'Rook': 'Rook',
    'Queen': 'Queen'
  }

    

end

