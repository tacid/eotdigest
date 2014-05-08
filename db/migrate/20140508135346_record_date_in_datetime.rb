class RecordDateInDatetime < ActiveRecord::Migration
  def self.up
    change_column :records, :date, :datetime
    change_column :records, :approved, :boolean, :default => :true
  end

  def self.down
    change_column :records, :date, :date
    change_column :records, :approved, :boolean, default: true
  end
end
