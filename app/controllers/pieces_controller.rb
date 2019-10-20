class PiecesController < ApplicationController
  before_action :find_piece, only: [:update, :show]

  
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
    x_path = piece_params[:x_coord].to_i
    y_path = piece_params[:y_coord].to_i
    new_rank =  piece_params[:promotion_type].to_s
    if @piece.promotion? == true
      @piece.update(piece_params)
      @piece.pawn_promote(new_rank)
      redirect_to @game
      flash[:notice] = 'You have successfully promoted your pawn! Please refresh the page.'
      @game.reload
    elsif @piece.valid_move?(x_path, y_path)
      @piece.update(initial_position?: false)
      @piece.move_to!(x_path, y_path)
      @piece.update_attributes(piece_params)
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @piece, status: :ok }
        @game.reload
        flash[:notice] = 'You move was successfully completed!'
      end   
    else
      flash[:alert] = 'Your move cannot be completed! Please try again.'
    end
    @game.reload
  end

  def show
    @game = @piece.game
    @pieces = @game.pieces  
  end

  private

  def find_piece
    @piece = Piece.find(params[:id])
    @game = @piece.game
  end

  def piece_params
    params.require(:piece).permit(:name, :color, :x_coord, :y_coord, :game_id, :player_id, :captured, :initial_position?, :promotion?, :promotion_type)
  end
end
