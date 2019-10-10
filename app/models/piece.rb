class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user, required: false
  
    def location(x,y)
      x = piece_params[:x_coord]
      y = piece_params[:y_coord]
    end
  
    def white?
      piece.color == 'white'
    end
  
    def black?
      !white?
    end
  
    def removed?
      if piece.params[x_coord: nil, y_coord: nil]
        piece.captured = true
      end
  end

  def has_moved?
    if piece.initial_postion? == true
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
      return true
    elsif x_path < 0 || x_path > 7
      return true
    else
      return false
    end
  end 

   def diagonal_move?(x_dif, y_dif)
    x_dif == y_dif
  end

  def is_obstructed?(x_path, y_path) 
    self.valid_move?
    return true if self.game.tile_taken?(x_path, y_path) && self.color == self.game.pieces.where(x_coord: x_path, y_coord: y_path).first.color
    return false if self.type == "Knight"

    if self.y_coord == y_path 
      if self.x_coord < x_path 
        (x_coord + 1).upto(x_path - 1) do |x|
          return true if self.game.tile_taken?(x, y_path)
        end 
      else 
        (x_coord - 1).downto(x_path + 1) do |x|
          return true if self.game.tile_taken?(x, y_path)
        end 
      end 
    elsif self.x_coord == x_path 
      if self.y_coord < y_path 
        (y_coord + 1).upto(y_path - 1) do |y|
          return true if self.game.tile_taken?(x_path, y)
        end 
      else 
        (y_coord - 1).downto(y_path + 1) do |y|
          return true if self.game.tile_taken?(x_path, y)
        end 
      end 
    elsif 
      if self.x_coord < x_path && self.y_coord < y_path 
        (x_coord + 1).upto(x_path - 1) do |x|
          (y_coord + 1).upto(y_path - 1) do |y|
            return true if self.game.tile_taken?(x, y) && (x - x_coord) == (y - y_coord)
          end 
        end 
      elsif self.x_coord > x_path && self.y_coord < y_path 
        (x_coord - 1).downto(x_path + 1) do |x|
          (y_coord + 1).upto(y_path - 1) do |y|
            return true if self.game.tile_taken?(x, y) && (x - x_coord) == (y - y_coord)
          end 
        end 
      elsif self.x_coord < x_path && self.y_coord > y_path 
        (x_coord + 1).upto(x_path - 1) do |x|
          (y_coord - 1).downto(y_path + 1) do |y|
            return true if self.game.tile_taken?(x, y) && (x - x_coord) == (y - y_coord)
          end 
        end 
      elsif self.x_coord > x_path && self.y_coord > y_path 
        (x_coord - 1).downto(x_path + 1) do |x|
          (y_coord - 1).downto(y_path + 1) do |y|
            return true if self.game.tile_taken?(x, y) && (x - x_coord) == (y - y_coord)
          end 
        else self.x_coord > x_path && self.y_coord > y_path 
          (x_coord - 1).downto(x_path + 1) do |x|
            (y_coord - 1).downto(y_path + 1) do |y|
              return true if self.game.tile_taken?(x, y) && (x - x_coord) == (y - y_coord).abs
            end 
          end
        end   
      end 
      return false
    end
  end

  def valid_move?(x_path, y_path)
    if on_the_board?(x_path, y_path) || (x_coord == x_path && y_coord == y_path)
      return true if legal_move?(x_path, y_path) && ! is_obstructed?(x_path, y_path)
    end
    flash[:danger] = "Move cannot be completed."
    return false
  end

  def move_to!(x_path, y_path)
    rival_piece = self.find_by(x_coord: x_path, y_coord: y_path)
    if rival_piece.present? && rival_piece.color != piece.color
      rival_piece.removed?
      update_attributes(x_coord: x_path, y_coord: y_path)
    elsif rival_piece.present? == false
      update_attributes(x_coord: x, y_coord: y)
    end
  end
end
