class CreateSurfboards < ActiveRecord::Migration[7.1]
  def change
    create_table :surfboards do |t|
      t.string :category, array: true
      t.float :size
      t.boolean :available, default: true
      t.string :tail
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
