class PiecesController < ApplicationController
  def new
    @piece = game.pieces.new
  end

  def create
    @piece = game.pieces.create(piece_params)
    if @piece.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:x_coord, :y_coord, :game_id, :player_id, :type)
  end
end

