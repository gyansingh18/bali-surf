class AddLocationToSurfboards < ActiveRecord::Migration[7.1]
  def change
    add_column :surfboards, :location, :string
  end
end
