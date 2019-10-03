class Pawn < Piece
  def unicode_symbol	
		return y_coord > 5 ? "&#9817;" : "&#9823;"
	end

	def legal_move?(x_path, y_path)
	  y_dif = (y_path - y_coord).abs
		(y_dif == 1)
		if (x_coord + 1) && (y_coord + 1) || (x_coord - 1) && (y_coord - 1)
			self.move_to! && != self.friendly_piece
		end
  end
end
