class AddChildrenCountCounterCacheField < ActiveRecord::Migration
  def self.up
    add_column :categories, :children_count, :integer
  end

  def self.down
    remove_column :categories, :children_count
  end
end
