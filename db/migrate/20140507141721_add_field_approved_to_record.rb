class AddFieldApprovedToRecord < ActiveRecord::Migration
  def self.up
    add_column :records, :approved, :boolean
  end

  def self.down
    remove_column :records, :approved
  end
end
