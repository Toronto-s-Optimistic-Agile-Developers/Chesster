# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games', type: :model do
  describe 'Scopes' do
    describe 'Game.available' do
      it 'shows available games' do
        create_games_with_two_players
        available1 = create_game_with_one_players
        available2 = create_game_with_one_players

        expect(Game.available).to match_array [available1, available2]
      end
      it 'shows no games when there are none available' do
        create_games_with_two_players

        expect(Game.available).to eq []
      end
    end

    def create_games_with_two_players
      player_1 = FactoryBot.create(:user)
      player_2 = FactoryBot.create(:user)
      Game.create(white_id: player_1, black_id: player_2)
    end

    def create_game_with_one_players
      player_1 = FactoryBot.create(:user)
      Game.create(white_id: player_1)
    end
  end
end
