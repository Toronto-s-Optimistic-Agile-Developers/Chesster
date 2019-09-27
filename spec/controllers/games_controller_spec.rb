require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#show' do
    it 'returns a success response' do
      get :show
      expect(response).to have_http_status(:success)
    end
    describe 'setup_board!' do
      it 'should add 16 white and 16 black pieces to board' do
        user = FactoryBot.create(:user)
        sign_in user
        game = FactoryBot.create(:game)
        game.set_up_board!
        expect(pieces.count).to eq(32)
      end
    end
  end

  describe 'game#new' do
    it 'returns a success response' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'game#edit' do
    it 'returns a success response' do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new Game' do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      expect do
        post :create
      end.to change(Game, :count).by(1)
    end

    it 'redirects to created game' do
      user = FactoryBot.create(:user)
      sign_in user
      game = game = FactoryBot.create(:game)
      post :create
      expect(response).to redirect_to(Game.last)
    end

    it "returns a success response (i.e. to display 'new' template)" do
      user = FactoryBot.create(:user)
      sign_in user
      game = game = FactoryBot.create(:game)
      post :create
      expect(response).to have_http_status(:success)
    end
  end
end

describe 'PUT #update' do
  it 'updates requested game' do
    user = FactoryBot.create(:user)
    sign_in user
    game = game = FactoryBot.create(:game)
    put :update
    game.reload
    skip('Add assertions for updated state')
  end

  it 'redirects to game' do
    user = FactoryBot.create(:user)
    sign_in user
    game = game = FactoryBot.create(:game)
    put :update
    expect(response).to redirect_to(game)
  end
end

describe 'DELETE #destroy' do
  it 'destroys requested game' do
    user = FactoryBot.create(:user)
    sign_in user
    game = game = FactoryBot.create(:game)
    expect do
      delete :destroy
    end.to change(Game, :count).by(-1)
  end

  it 'redirects to games list' do
    user = FactoryBot.create(:user)
    sign_in user
    game = game = FactoryBot.create(:game)
    delete :destroy
    expect(response).to redirect_to(games_url)
  end

  describe 'set_up_board!' do
    it 'Adds correct number of white Pawns to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 0, y_coord: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 1, y_coord: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 2, y_coord: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 3, y_coord: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 4, y_coord: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 5, y_coord: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 6, y_coord: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 7, y_coord: 1).type).to eq 'Pawn'
    end
  end

  describe 'set_up_board!' do
    it 'Adds white Rook to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 0, y_coord: 0).type).to eq 'Rook'
    end
  end

  describe 'set_up_board!' do
    it 'Adds white Rook to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 7, y_coord: 0).type).to eq 'Rook'
    end
  end

  describe 'set_up_board!' do
    it 'Adds white Knight to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 1, y_coord: 0).type).to eq 'Knight'
    end
  end

  describe 'set_up_board!' do
    it 'Adds white Knight to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 6, y_coord: 0).type).to eq 'Knight'
    end
  end

  describe 'set_up_board!' do
    it 'Adds white Bishop to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 2, y_coord: 0).type).to eq 'Bishop'
    end
  end

  describe 'set_up_board!' do
    it 'Adds white Bishop to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 5, y_coord: 0).type).to eq 'Bishop'
    end
  end

  describe 'set_up_board!' do
    it 'Adds white King to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 4, y_coord: 0).type).to eq 'King'
    end
  end

  describe 'set_up_board!' do
    it 'Adds white Queen to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 3, y_coord: 0).type).to eq 'Queen'
    end
  end

  # Adds black pieces to board

  describe 'set_up_board!' do
    it 'Adds correct number of black Pawns to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 0, y_coord: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 1, y_coord: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 2, y_coord: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 3, y_coord: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 4, y_coord: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 5, y_coord: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 6, y_coord: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_coord: 7, y_coord: 6).type).to eq 'Pawn'
    end
  end

  describe 'set_up_board!' do
    it 'Adds black Rook to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 0, y_coord: 7).type).to eq 'Rook'
    end
  end

  describe 'set_up_board!' do
    it 'Adds black Rook to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 7, y_coord: 7).type).to eq 'Rook'
    end
  end

  describe 'set_up_board!' do
    it 'Adds black Knight to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 1, y_coord: 7).type).to eq 'Knight'
    end
  end

  describe 'set_up_board!' do
    it 'Adds black Knight to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 6, y_coord: 7).type).to eq 'Knight'
    end
  end

  describe 'set_up_board!' do
    it 'Adds black Bishop to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 2, y_coord: 7).type).to eq 'Bishop'
    end
  end

  describe 'set_up_board!' do
    it 'Adds black Bishop to board' do
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 5, y_coord: 7).type).to eq 'Bishop'
    end
  end

  describe 'set_up_board!' do
    it 'Adds black King to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 4, y_coord: 7).type).to eq 'King'
    end
  end

  describe 'set_up_board!' do
    it 'Adds black Queen to board' do
      user = FactoryBot.create(:user)
      sign_in user
      game = Game.create!
      game.set_up_board!

      expect(game.pieces.find_by(x_coord: 3, y_coord: 7).type).to eq 'Queen'
    end
  end
end


