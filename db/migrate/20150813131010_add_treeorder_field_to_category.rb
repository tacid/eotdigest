class AddTreeorderFieldToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :treeorder, :string, :chars => 20
  end

  def self.down
    remove_column :categories, :treeorder
  end
end
