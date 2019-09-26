class Game  < ApplicationRecord
  belongs_to :white_id, class_name: 'User', optional: true
  belongs_to :black_id, class_name: 'User', optional: true
  has_many :pieces
  after_create :set_up_board!
  validates :name, presence: true
 

  def set_up_board!
    # Rooks
    [0, 7].each do |x_coord|
      Rook.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7, user_id: white_id, name: "White_rook")
    end

    # Knights
    [1, 6].each do |x_coord|
      Knight.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7, user_id: white_id, name: "White_Knight")
    end

    #Bishops
    [2, 5].each do |x_coord|
      Bishop.create(game_id: id, color: "white", x_coord: x_coord, y_coord: 7, user_id: white_id, name: "White_Bishop")
    end

    #King
    King.create(game_id: id, color: "white", x_coord: 3, y_coord: 7, user_id: white_id, name: "White_King")

  

    #Queen
    Queen.create(game_id: id, color: "white", x_coord: 2, y_coord: 7, user_id: white_id, name: "White_Queen")

  
    #Black Pieces
    (0..7).each do |x_coord|
      Pawn.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 1, user_id: black_id, name: "Black_Pawn")
    end

    [0, 7].each do |x_coord|
      Rook.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, user_id: black_id, name: "Black_Rook")
    end

    [2, 7].each do |x_coord|
      Knight.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, user_id: black_id, name: "Black_Knight")
  end

  [3, 6].each do |x_coord|
    Bishop.create(game_id: id, color: "black", x_coord: x_coord, y_coord: 0, user_id: black_id, name: "Black_Bishop")
  end

   King.create(game_id: id, color: "black", x_coord: 4, y_coord: 0, user_id: black_id, name: "Black_King")


 Queen.create(game_id: id, color: "black", x_coord: 3, y_coord: 0, user_id: black_id, name: "Black_Queen")
  end

end

