class PiecesController < ApplicationController
  
  def create
    @pieces = current_game.pieces.create(piece_params)
  end

  def show
    @piece = Piece.find(params[:id])
  end


  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    x = piece_params[:x_coord]
    y = piece_params[:y_coord]
    
  end

  private

  def piece_params
    params.require(:piece).permit(:color, :x_coord, :y_coord, :type)
  end

  
end

