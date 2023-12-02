class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :link
      t.string :asin
      t.decimal :price, precision: 10, scale: 2
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
