class AddIndextoXcoodYcoord < ActiveRecord::Migration[5.2]
  def change
    add_index :pieces, :x_coord
    add_index :pieces, :y_coord
  end
end
