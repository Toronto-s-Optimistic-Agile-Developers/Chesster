class AddTitleToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :title, :string
  end
end
