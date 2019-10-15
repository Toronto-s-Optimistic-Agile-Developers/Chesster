class AddInitialPositionToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :initial_position?, :boolean, :default => true
  end
end
