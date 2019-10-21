class Knight < Piece
  def unicode_symbol
		return "&#9822;"	
	end

  def legal_move?(x_path, y_path)
    x_dif = (x_path - x_coord).abs
    y_dif = (y_path - y_coord).abs
    (x_dif == 1 && y_dif == 2) || (x_dif == 2 && y_dif == 1)
  end
end
