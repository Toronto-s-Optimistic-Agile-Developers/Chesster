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

  def promote
    @piece.update_attributes(params[:type])
  end

  def update
    @piece = Piece.find_by(params[:id])
    x_path = @piece.x_coord
    y_path = @piece.y_coord
    if @piece.valid_move?(x_path, y_path)
      @piece.move_to!(x_path, y_path)  
      @piece.update_attributes(params[:initial_position? => false])
      @piece.update_attributes(piece_params)
    end
  end  

  private

  def find_piece
    @piece = Piece.find(params[:id])
    @color = @piece.color
    @game = @piece.game
  end
  
  def piece_params
    params.require(:piece).permit(:name, :color, :x_coord, :y_coord, :game_id, :player_id, :type, :initial_postion?)
  end
end

