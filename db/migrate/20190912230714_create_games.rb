# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :username
      t.integer :player_id
      t.integer :white_id
      t.integer :black_id
      t.timestamps
    end
    add_index :users, :id
    add_index :users, :username
  end
end
