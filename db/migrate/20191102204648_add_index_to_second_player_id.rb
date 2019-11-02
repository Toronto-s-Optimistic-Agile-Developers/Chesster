class AddIndexToSecondPlayerId < ActiveRecord::Migration[5.2]
  def change
    add_index :games, :second_player_id
  end
end
