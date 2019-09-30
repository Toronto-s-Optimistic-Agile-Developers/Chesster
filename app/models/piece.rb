class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :user, required: false
  
   
end