class King < Piece
  
  def unicode_symbol
		return "&#9818;"
	end

  def legal_move?(x_path, y_path)
    x_dif = (x_path - x_coord).abs
    y_dif = (y_path - y_coord).abs
    if x_dif >= 2 || y_dif >= 2
      return false
    elsif x_dif == 0 && y_dif == 0
      return false
    else (x_dif <= 1) && (y_dif <= 1) && (x_dif + y_dif > 0)
      return true
    end
  end
end
