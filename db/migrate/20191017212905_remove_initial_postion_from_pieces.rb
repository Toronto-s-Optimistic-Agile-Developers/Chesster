class RemoveInitialPostionFromPieces < ActiveRecord::Migration[5.2]
  def change
    remove_column :pieces, :initial_postion?, :boolean, :default => true
  end
end
