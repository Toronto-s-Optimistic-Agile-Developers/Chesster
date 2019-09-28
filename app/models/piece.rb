class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user, required: false
  
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
        piece.captured = true
      end
  end
  
    def valid_move?
    end
  
    def has_moved?
      if piece.initial_postion?
        false
      end
    end

  def move_to!(x, y)
    rival_piece = game.pieces.find_by(x_coord: x, y_coord: y)
    if rival_piece.present? && rival_piece.color != color
      rival_piece.update_attributes(x_coord: nil, y_coord: nil, captured: true)
      update_attributes(x_coord: x, y_coord: y)
    elsif rival_piece.present? == false
      update_attributes(x_coord: x, y_coord: y)
    else
      flash[:danger] = "Move cannot be completed."
    end
  end
end