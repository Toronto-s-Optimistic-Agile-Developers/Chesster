class PiecesController < ApplicationController

  private

  def peice_params
    params.require(:piece).permit(:x_coord, :y_coord, :game_id, :player_id)
  end
end
