# frozen_string_literal: true

class CreatePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :pieces do |t|
      t.string :type
      t.integer :x_coord
      t.integer :y_coord
      t.integer :game_id
      t.integer :player_id
      t.timestamps
    end
    add_index :games, :id
    add_index :games, :player_id
  end
end
