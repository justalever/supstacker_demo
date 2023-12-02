class CreateProductStacks < ActiveRecord::Migration[7.1]
  def change
    create_table :product_stacks do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :stack, null: false, foreign_key: true

      t.timestamps
    end
  end
end
