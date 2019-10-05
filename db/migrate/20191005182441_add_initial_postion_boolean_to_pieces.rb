class AddInitialPostionBooleanToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :initial_postion?, :boolean, :default => true
  end
end
