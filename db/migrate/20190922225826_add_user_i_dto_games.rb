class AddUserIDtoGames < ActiveRecord::Migration[5.2]
  def change
  	add_index :games, :user_id
  end
end
