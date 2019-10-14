class PiecesController < ApplicationController
  before_action :find_piece, :authenticate_move

  
  def create
    @piece = game.pieces.create(piece_params)
    if @piece.valid?
      redirect_to games_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @piece = Piece.find(params[:id])
  end

  def update
    @piece = Piece.find(params[:id])
    x_path = piece_params[:x_coord].to_i
    y_path = piece_params[:y_coord].to_i
    if authenticate_move 
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @piece, status: :ok }
        @piece.update_attributes(piece_params)
      end
    else 
      flash[:alert] = 'Your move cannot be completed!'
      @pieces.game.reload
    end
  end

  def show
    @piece = Piece.find_by_id(params[:id])
    @game = @piece.game
    @pieces = @game.pieces  
  end

  private

  def authenticate_move
    return if @piece.valid_move?(piece_params[:x_coord].to_i, piece_params[:y_coord].to_i) || @piece.promote?(piece_params[:x_coord].to_i, piece_params[:y_coord].to_i)
  end

  def find_piece
    @piece = Piece.find(params[:id])
    @color = @piece.color
    @game = @piece.game
  end
  
  def piece_params
    params.permit(:id, :name, :color, :x_coord, :y_coord, :game_id, :player_id, :type, :captured, :initial_postion?)
  end
end
