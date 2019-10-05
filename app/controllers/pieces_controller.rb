class PiecesController < ApplicationController

  

  

  def show
    @piece = Piece.find_by_id(params[:id])
    @game = @piece.game
    @pieces = @game.pieces  
  end

  
end

