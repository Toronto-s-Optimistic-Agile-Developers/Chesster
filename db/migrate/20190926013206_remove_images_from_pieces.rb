class RemoveImagesFromPieces < ActiveRecord::Migration[5.2]
  def change
    remove_column :pieces, :image, :string
  end
end
