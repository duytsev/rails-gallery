class RemoveCvalueFromCategorization < ActiveRecord::Migration
  def change
    remove_column :categorizations, :cvalue, :string
  end
end
