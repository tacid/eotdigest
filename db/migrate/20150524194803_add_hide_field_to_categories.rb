class AddHideFieldToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :hide, :boolean
  end

  def self.down
    remove_column :categories, :hide
  end
end
