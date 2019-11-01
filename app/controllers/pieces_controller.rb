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
       flash[:notice] = 'You have successfully promoted your pawn!'
      @game.reload
    elsif piece = @piece.name == "Black_King" && ! @piece.legal_move?(x_path, y_path)
      if @piece.black_left_castle(x_path, y_path) == true
        @piece.black_left_castle(x_path, y_path)
        @game.reload
        flash[:notice] = 'You have successfully completed Castling.'
      elsif @piece.black_left(x_path, y_path) == true
        @piece.black_left_castle(x_path, y_path)
        @game.reload
        flash[:notice] = 'You have successfully completed Castling.'
      end
    elsif @piece.name == "White_King" && ! @piece.legal_move?(x_path, y_path)
      if @piece.white_right_castle(x_path, y_path) == true 
        @piece.white_right_castle(x_path, y_path)
        @game.reload
      elsif @piece.white_left_castle(x_path, y_path) == true
        @piece.white_left_castle(x_path, y_path)
        flash[:notice] = 'You have successfully completed Castling.'
      elsif @piece.white_left(x_path, y_path) == true
        @game.reload
      end
    elsif @piece.valid_move?(x_path, y_path)
      @piece.move_to!(x_path, y_path)
      @piece.update(initial_position?: false)
      @piece.update_attributes(piece_params)
        respond_to do |format|
          format.html { render :show }
          format.json { render json: @piece, status: :ok }
        end
      @game.reload
    elsif @piece.name == "White_King" && @piece.in_check?(color)
      flash[:alert] = 'C H E C K'
    elsif @piece.name == "Black_King" && @piece.in_check?(color)
      flash[:alert] = 'C H E C K'
    else
      flash[:notice] = 'Your move was successfully completed!' 
    end
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
