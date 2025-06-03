class AddImageToSurfboards < ActiveRecord::Migration[7.1]
  def change
    add_column :surfboards, :image_url, :string
  end
end
