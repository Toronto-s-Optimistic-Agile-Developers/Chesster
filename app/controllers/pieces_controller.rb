class PiecesController < ApplicationController
  before_action :find_piece, only: [:update]

  
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
    elsif (@piece.(name: "Black_King", x_coord: 0, initial_position?: true) || @piece.(name: "Black_King", x_coord: 7, initial_position?: true))  || (@piece.(name: "White_King", x_coord: 0, initial_position?: true) || @piece.(name: "White_King", x_coord: 7, initial_position?: true))
      @piece.update(x_coord: x_coord)
      castle(x_path, y_path)
    elsif @piece.valid_move?(x_path, y_path)
      @piece.move_to!(x_path, y_path)
      @piece.update(initial_position?: false)
      @piece.update_attributes(piece_params)
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @piece, status: :ok }
      end
        @game.reload
        flash[:notice] = 'You move was successfully completed!'  
    end
    @game.reload
  end

  private

  def find_piece
    @piece = Piece.find(params[:id])
    @game = @piece.game
  end

  def piece_params
    params.require(:piece).permit(:id, :name, :color, :x_coord, :y_coord, :game_id, :player_id, :captured, :initial_position?, :promotion?, :promotion_type, :title)
  end
end
