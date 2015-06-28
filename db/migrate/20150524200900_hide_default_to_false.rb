class HideDefaultToFalse < ActiveRecord::Migration
  def self.up
    change_column :categories, :hide, :boolean, :limit => 1, :default => false
  end

  def self.down
    change_column :categories, :hide, :boolean
  end
end
