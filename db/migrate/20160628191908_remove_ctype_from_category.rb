class RemoveCtypeFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :ctype, :integer
  end
end
