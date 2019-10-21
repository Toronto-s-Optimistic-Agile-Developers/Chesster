class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user, required: false

  # def self.types
  #   unscoped.select(:type).distinct.pluck(:type)
  # end
  # Piece.descendants.map {|klass| klass.name.demodulize }
    def location(x,y)
      x_coord = piece_params[:x_coord].to_i
      y_coord= piece_params[:y_coord].to_i
    end
  
    def white?
      piece.color == 'white'
    end
  
    def black?
      !white?
    end
  
    def removed?
      if piece.params[x_coord: nil, y_coord: nil]
        self.update(captured: true, x_coord: nil, y_coord: nil)
      end
  end

  def has_moved?
    if self.initial_postion? == true
      return false
    else
      return true
    end
  end

  

  def friendly_piece
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

  def is_obstructed?(x_path, y_path) 
    return true if self.game.tile_taken?(x_path, y_path) && self.color == self.game.pieces.where(x_coord: x_path, y_coord: y_path).first.color
    return false if self.type == "Knight"

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

  def move_to!(x_path, y_path)
    rival_piece = Piece.find_by(x_coord: x_path, y_coord: y_path)
    if ! is_obstructed?
      if self.type == Pawn && rival_piece.color != self.color
        (x_path == 1) && (y_path == 1)
      elsif rival_piece.present? && rival_piece.color != self.color
        rival_piece.removed?
        update_attributes(x_coord: x_path, y_coord: y_path)
      elsif rival_piece.present? == false
        update_attributes(x_coord: x, y_coord: y)
      end
    end
  end

  def valid_move?(x_path, y_path)
    #
    #  byebug
    if on_the_board?(x_path, y_path) && ! ((x_coord == x_path) && (y_coord == y_path))
      if legal_move?(x_path, y_path) && ! is_obstructed?(x_path, y_path)
        return true 
      else
        return false
      end
    end
  end

  def promote?(x_path, y_path)
    if self.type == Pawn && ((y_coord == 7 && color == "black") || (y_coord == 0 && color == "white"))
      1.times do 
        @piece.game.reload
      end
      return true
		end
  end
  
  RANK = {
    'Knight': 'Knight',
    'Bishop': 'Bishop',
    'Rook': 'Rook',
    'Queen': 'Queen'
  }
  
end
