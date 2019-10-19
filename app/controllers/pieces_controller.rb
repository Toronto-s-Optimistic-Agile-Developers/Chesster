class PiecesController < ApplicationController
  before_action :find_piece

  
  def create
    @piece = game.pieces.create(piece_params)
    if @piece.valid?
      redirect_to games_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    x_path = piece_params[:x_coord].to_i
    y_path = piece_params[:y_coord].to_i
    if @piece.promotion? == true
      @piece.update(piece_params)
      @piece.update_pawn
      redirect_to @game
    elsif @piece.valid_move?(x_path, y_path)
      @piece.update(initial_position?: false)
      @piece.move_to!(x_path, y_path)
      @piece.update_attributes(piece_params)
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @piece, status: :ok }
      end
      @game.reload
    else 
      flash[:alert] = 'Your move cannot be completed!'
      # @game.reload
    end
  end

  def show
    @piece = Piece.find(params[:id])
    @game = @piece.game
    @pieces = @game.pieces  
  end

  def update_pawn  
    
  end

  private


  def find_piece
    @piece = Piece.find(params[:id])
    @color = @piece.color
    @game = @piece.game
  end
  
  def piece_params
    params.permit(:id, :name, :color, :x_coord, :y_coord, :game_id, :player_id, :type, :captured, :initial_postion?, :promotion?, :promotion_type)
  end
end
