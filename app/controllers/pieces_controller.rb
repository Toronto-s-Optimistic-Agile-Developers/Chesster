<<<<<<< HEAD
class PiecesController < ApplicationController

  private

  def peice_params
    params.require(:piece).permit(:x_coord, :y_coord, :game_id, :player_id)
  end
end
=======
class PiecesController < ApplicationController

  private

  def piece_params
    params.require(:piece).permit(:x_coord, :y_coord, :game_id, :player_id, :type)
  end
end
>>>>>>> 6d0cfcb939150325807db57d6c09403f60bc8f89
