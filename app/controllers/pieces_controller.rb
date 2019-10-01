class PiecesController < ApplicationController

  before_action :find_piece

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

  def show
    @piece = Piece.find_by_id(params[:id])
    @game = @piece.game
    @pieces = @game.pieces  
  end

  def update
    @pieces.update_attributes(type: params[:piece][:x_coord][:y_coord])
    redirect_to game_path(@game)
  end

  private

  def find_piece
    @piece = Piece.find(params[:id])
    @color = @piece.color
    @game = @piece.game
  end

  def piece_params
    params.require(:piece).permit(:name, :color, :x_coord, :y_coord, :game_id, :player_id, :type)
  end
end
