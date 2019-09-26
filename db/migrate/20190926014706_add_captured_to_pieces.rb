class AddCapturedToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :captured, :boolean, :default => false
  end
end
