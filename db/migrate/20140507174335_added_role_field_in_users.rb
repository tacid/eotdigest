class AddedRoleFieldInUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string, :default => :viewer
  end

  def self.down
    remove_column :users, :role
  end
end
