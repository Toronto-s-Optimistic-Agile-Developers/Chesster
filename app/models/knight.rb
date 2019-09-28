class Knight < Piece
  def unicode_symbol
		return y_coord > 5 ? "&#9816;" : "&#9822;"	
	end
end