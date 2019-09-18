require 'rails_helper'


RSpec.describe GamesController, type: :controller do

  describe "games#index" do
    it "returns a success response" do
      get :index
     expect(response).to have_http_status(:success)
    end
  end

  describe "gmaes#show" do
    it "returns a success response" do
      get :show
     expect(response).to have_http_status(:success)
    end
  end

  describe "game#new" do
    it "returns a success response" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "game#edit" do
    it "returns a success response" do
      user = FactoryBot.create(:user)
      sign_in user
      game = game = FactoryBot.create(:game)  
      get :edit 
     expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a new Game" do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      expect {
        post :create 
      }.to change(Game, :count).by(1)
    end

      it "redirects to the created game" do
        user = FactoryBot.create(:user)
        sign_in user
        game = game = FactoryBot.create(:game)  
        post :create 
        expect(response).to redirect_to(Game.last)
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        user = FactoryBot.create(:user)
        sign_in user
        game = game = FactoryBot.create(:game)  
        post :create 
       expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PUT #update" do
    it "updates the requested game" do
      user = FactoryBot.create(:user)
      sign_in user
      game = game = FactoryBot.create(:game)  
      put :update 
      game.reload
      skip("Add assertions for updated state")
    end

    it "redirects to the game" do
      user = FactoryBot.create(:user)
      sign_in user
      game = game = FactoryBot.create(:game)  
      put :update
      expect(response).to redirect_to(game)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested game" do
      user = FactoryBot.create(:user)
      sign_in user
      game = game = FactoryBot.create(:game)  
      expect {
        delete :destroy 
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      user = FactoryBot.create(:user)
      sign_in user
      game = game = FactoryBot.create(:game)  
      delete :destroy 
      expect(response).to redirect_to(games_url)
    end
  end
