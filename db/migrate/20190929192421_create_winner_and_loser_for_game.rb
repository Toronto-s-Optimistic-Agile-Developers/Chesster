class CreateWinnerAndLoserForGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :winner, :integer
    add_column :games, :loser, :integer
  end
end
