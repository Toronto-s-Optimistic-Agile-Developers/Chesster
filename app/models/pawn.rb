class Pawn < Piece
  def unicode_symbol	
		return "&#9823;"
	end

	def promote?(y_path)
    if self.type == Pawn && ((self.y_coord == 7 && self.color == "white") || (self.y_coord == 0 && self.color == "black"))
       self.update(promotion?: true)
      return true
		end
  end

	def legal_move?(x_path, y_path)
	  y_dif = (y_path - y_coord)
		x_dif = (x_path - x_coord)
		up = self.color == "white" ? -1 : 1
		if ! self.has_moved?
			return (x_dif == 0 && y_dif == up) || (x_dif == 0 && y_dif == 2*up)
		else
			if self.promotion? 
				self.update(promotion?: true)
			end
			return (x_dif == 0 && y_dif == up)
		end
	end
end
