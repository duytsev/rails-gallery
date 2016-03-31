class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|

      t.timestamps null: false
    end

    add_reference :photos, :upload, index: true
    add_foreign_key :photos, :uploads
  end
end
