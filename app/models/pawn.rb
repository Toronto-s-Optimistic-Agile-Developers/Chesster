class Pawn < Piece
	attr_reader :up
  def unicode_symbol	
		return "&#9823;"
	end

	def legal_move?(x_path, y_path)
		y_dif = (y_path - y_coord)
		x_dif = (x_path - x_coord)
		@up = self.color == "white" ? -1 : 1
		return false if is_obstructed?(x_path, y_path)
		if ! self.game.tile_taken?(x_path, y_path)
			if ! self.has_moved?
				return (x_dif == 0 && y_dif == up) || (x_dif == 0 && y_dif == 2*up)
			else
				return (x_dif == 0 && y_dif == up)  
			end
		end
	end
end