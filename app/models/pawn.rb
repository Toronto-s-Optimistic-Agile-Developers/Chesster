class Pawn < Piece
  def unicode_symbol	
		return y_coord > 5 ? "&#9817;" : "&#9823;"
		
	end
end
