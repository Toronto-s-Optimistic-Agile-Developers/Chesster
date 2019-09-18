<<<<<<< HEAD
class GamesController < ApplicationController
  
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy] 
  before_action :set_game, only: [:create, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game.create(game_params)
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = current_user.games.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:username, :player_id, :white_id, :black_id)
    end

    def player_id
      current_user.id = player_id
    end
end
=======
class GamesController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
  end

  def index
    redirect_to #path ??
  end

  def update
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_id, :black_id)
  end

>>>>>>> 6d0cfcb939150325807db57d6c09403f60bc8f89
