# frozen_string_literal: true

class PiecesController < ApplicationController
  private

  def piece_params
    params.require(:piece).permit(:x_coord, :y_coord, :game_id, :player_id, :type)
  end
end
