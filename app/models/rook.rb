class Rook < Piece
  def unicode_symbol	
		return y_coord > 5 ? "&#9814;" : "&#9820;"
	end
end