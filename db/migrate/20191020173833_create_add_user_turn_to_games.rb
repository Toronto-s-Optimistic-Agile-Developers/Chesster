class CreateAddUserTurnToGames < ActiveRecord::Migration[5.2]
  def change
      add_column :games, :user_turn, :string
  end
end
