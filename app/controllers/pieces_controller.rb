class PiecesController < ApplicationController
  before_action :find_piece
  before_action :location
  
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

  def update
    x_path = @piece.x_coord
    y_path = @piece.y_coord
    if @piece.valid_move?(x_path, y_path)
      @piece.move_to!(x_path, y_path)  
      @piece.update_attributes(piece_params)
    end
  end  
  
  def show
    @piece = Piece.find(params[:id])
    @game = @piece.game
    @pieces = @game.pieces  
  end


  private

  def promote?
    @pieces = Piece.find(params[:id])
    @pieces.update_attributes(piece_params)
  end

  def find_piece
    @piece = Piece.find(params[:id])
    @color = @piece.color
    @game = @piece.game
  end
  
  def piece_params
    params.require(:piece).permit(:name, :color, :x_coord, :y_coord, :game_id, :player_id, :type, :initial_postion?)
  end

  def location
    x_path = @piece.x_coord
    y_path = @piece.y_coord
  end
end
