class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :photo_id
      t.integer :category_id
      t.string :cvalue

      t.timestamps null: false
    end

    add_index :categorizations, [:photo_id, :category_id], unique: true
    add_index :categorizations, [:category_id, :photo_id], unique: true

    add_foreign_key :categorizations, :photos
    add_foreign_key :categorizations, :categories
  end
end
