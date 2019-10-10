class Rook < Piece
  def unicode_symbol	
		return y_coord > 5 ? "&#9814;" : "&#9820;"
	end

   def legal_move?(x_path, y_path)
    x_dif = (x_path - x_coord).abs
    y_dif = (y_path - y_coord).abs
    return false if is_obstructed?(x_path, y_path)
    (x_dif >= 1 && y_dif == 0) || (y_dif >= 1 && x_dif == 0)
  end
end