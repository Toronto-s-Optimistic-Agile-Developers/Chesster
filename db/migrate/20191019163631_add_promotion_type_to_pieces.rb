class AddPromotionTypeToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :promotion_type, :string
  end
end
