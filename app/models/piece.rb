class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user, required: false
  
   def as_json(options={})
    super(options.merge({:methods => :type}))
  end

    def white?
      piece.color == 'white'
    end
  
    def black?
      !white?
    end
  
    def removed?
      self.update(captured: true, x_coord: nil, y_coord: nil)
  end

  def has_moved?
    if self.initial_position? == true
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
    if (self.name == "White_Pawn" || self.name == "Black_Pawn") && rival_piece.color != self.color
      ((x_path == x_path + 1) && (y_path == y_path + 1))
      rival_piece.removed?
    elsif self.type == Queen && rival_piece.color != self.color
      rival_piece.removed?
    elsif rival_piece.present? && rival_piece.color != self.color
      ((x_path == 1) && (y_path == 1))
      rival_piece.removed?
      update_attributes(x_coord: x_path, y_coord: y_path)
    elsif rival_piece.present? == false
      update(x_coord: x_path, y_coord: y_path)
    end
  end

  def valid_move?(x_path, y_path)
    if on_the_board?(x_path, y_path) && ! ((x_coord == x_path) && (y_coord == y_path))
      if legal_move?(x_path, y_path) && ! is_obstructed?(x_path, y_path)
        return true 
      else
        return false
      end
    end
  end

  def pawn_promote
    pawn = Piece.find_by(x_coord, y_coord)
    "#{pawn.promotion_type}".create(x_coord: pawn.x_coord, y_coord: pawn.y_coord, name: "Promoted #{pawn.promotion_type}")
    pawn.destroy
  end
end