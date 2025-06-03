class AddPriceToSurfboards < ActiveRecord::Migration[7.1]
  def change
    add_column :surfboards, :price, :float
  end
end
