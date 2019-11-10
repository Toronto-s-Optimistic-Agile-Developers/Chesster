class AddSecondPlayerIdToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :second_player_id, :integer
  end
end
