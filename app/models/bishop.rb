class Bishop < Piece
  def unicode_symbol  
    return "&#9821;"
  end

  def legal_move?(x_path, y_path)
    x_dif = (x_path - x_coord).abs
    y_dif = (y_path - y_coord).abs
    (x_dif >= 1 && y_dif >= 1) && diagonal_move?(x_dif, y_dif)
  end
end
