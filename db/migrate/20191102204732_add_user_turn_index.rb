class AddUserTurnIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :games, :user_turn
    add_index :pieces, :name
    add_index :pieces, :title
  end
end
