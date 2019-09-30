class Knight < Piece
  def unicode_symbol
		return y_coord > 5 ? "&#9816;" : "&#9822;"	
	end

  def legal_move?(x_path, y_path)
    return false if x_coord == x_path || y_coord == y_path
    return true if knight_moves?(x, y)
    false
    end 
    

  end

  def knight_moves?(x_path, y_path)
    (x_path == 1 && y_path == 2) || (x_path == 2 && y_path == 1)
  end
end
