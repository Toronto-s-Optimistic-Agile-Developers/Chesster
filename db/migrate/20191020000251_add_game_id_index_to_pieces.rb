class AddGameIdIndexToPieces < ActiveRecord::Migration[5.2]
  def change
    add_index :pieces, :game_id
  end
end
