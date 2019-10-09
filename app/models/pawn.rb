class Pawn < Piece
  def unicode_symbol	
		return y_coord > 5 ? "&#9817;" : "&#9823;"
	end

	def legal_move?(x_path, y_path)
	  y_dif = (y_path - y_coord)
		x_dif = (y_path - x_coord)
		if has_moved?
			(x_dif == 0 && y_dif == 1) || (x_dif == 0 && y_dif == 2)
		else
			(x_dif == 0 && y_dif == 1)
		end
	end

	def promote?
		if Pawn.white? && Pawn.y_coord == 7 || Pawn.black? && y_coord == 0
			return true
		end
	end
end
