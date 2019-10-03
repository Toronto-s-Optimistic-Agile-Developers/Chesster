class Pawn < Piece
  def unicode_symbol	
		return y_coord > 5 ? "&#9817;" : "&#9823;"
	end
	
	def legal_move?(x_path, y_path)
    y_dif = (y_path - y_coord).abs
    (x_dif == 0 && y_dif == 1)
  end
end
