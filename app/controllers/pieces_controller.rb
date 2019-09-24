class PiecesController < ApplicationController
  def new
    @piece = game.pieces.new
  end

  def create
    @piece = game.pieces.create(piece_params)
    if @piece.valid?
      redirect_to games_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:name, :color, :x_coord, :y_coord, :game_id, :image, :type)
  end
end

