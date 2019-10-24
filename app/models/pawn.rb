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

		# Straight up and down
		valid_difs = [[0, up]]
		valid_difs << [0, 2*up] unless self.has_moved?
		return !piece_at(x_path, y_path).present? if valid_difs.include?([x_dif, y_dif])

		# Check Diagonals

		valid_moves = [[x_coord + 1, y_coord + up], [x_coord - 1, y_coord + up]]
		valid_moves.each do |valid|
			piece = piece_at(valid[0], valid[1])
			return true if piece.present? && piece.color != self.color
		end

		false
	end

	def piece_at(x_path, y_path)
		Piece.find_by(game_id: self.game_id, x_coord: x_path, y_coord: y_path)
	end
end