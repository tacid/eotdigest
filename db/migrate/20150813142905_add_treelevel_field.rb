class AddTreelevelField < ActiveRecord::Migration
  def self.up
    add_column :categories, :treelevel, :integer
  end

  def self.down
    remove_column :categories, :treelevel
  end
end
