class Rook < Piece
  def unicode_symbol	
		return y_coord > 5 ? "&#9813;" : "&#9819;"
	end
end