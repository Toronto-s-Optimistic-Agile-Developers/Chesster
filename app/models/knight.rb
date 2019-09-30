class Knight < Piece
  def unicode_symbol
		return y_coord > 5 ? "&#9816;" : "&#9822;"	
	end

  def legal_move?(x, y)
    #move must be to new square
    return false if x_coord == x || y_coord == y
    return true if knight_moves?(x, y)
    false
    end 
    

  end

  def knight_moves?(x, y)
    (x_path == 1 && y_path == 2) || (x_path == 2 && y_path == 1)
  end
end
