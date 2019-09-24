class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def location(x,y)
    x = piece_params[:x_coord]
    y = piece_params[:y_coord]
  end

  def color
    color ? 'white' : 'black'
  end

  def white?
    white
  end

  def black?
    !white
  end

  def removed?
    if piece.params[x_coord: nil, y_coord: nil]
      true
    end
end

  def valid_move?
  end

  def has_moved?
    if piece.initial_postion?
      false
    end
  end
end
