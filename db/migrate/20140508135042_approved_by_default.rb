class ApprovedByDefault < ActiveRecord::Migration
  def self.up
    change_column :records, :approved, :boolean, default: true
  end

  def self.down
    change_column :records, :approved, :boolean
  end
end
