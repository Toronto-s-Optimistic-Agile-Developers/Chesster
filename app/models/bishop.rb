class Bishop < Piece
  def unicode_symbol	
		return y_coord > 5 ? "&#9815;" : "&#9821;"
	end
end
