class ChangeCategoryToNonArrayInSurfboards < ActiveRecord::Migration[7.1]
  def change
    change_column :surfboards, :category, :string, array: false, default: nil
  end
end
