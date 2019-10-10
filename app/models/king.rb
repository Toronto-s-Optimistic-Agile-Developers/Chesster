class King < Piece
  def unicode_symbol
		return y_coord > 5 ? "&#x2654;"	: "&#9818;"
	end
end