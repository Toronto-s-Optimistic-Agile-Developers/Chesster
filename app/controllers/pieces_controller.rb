class PiecesController < ApplicationController
 # before_action :find_piece
  
  #def new
   # @piece = game.pieces.new
  #end

  def create
    @piece = game.pieces.create(piece_params)
    if @piece.valid?
      redirect_to games_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @piece = Piece.find(params[:id])
    @piece.update_attributes(piece_params)
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @piece, status: :ok }
    end

  end  
  
  def show
    @piece = Piece.find_by_id(params[:id])
    @game = @piece.game
    @pieces = @game.pieces  
  end


  private

  def find_piece
    @piece = Piece.find(params[:id])
    @color = @piece.color
    @game = @piece.game
  end
  
  def piece_params
    params.permit(:id, :name, :color, :x_coord, :y_coord, :game_id, :player_id, :type, :initial_postion?)
  end
end
