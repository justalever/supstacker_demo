class CreateStacks < ActiveRecord::Migration[7.1]
  def change
    create_table :stacks do |t|
      t.string :title
      t.string :share_link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
