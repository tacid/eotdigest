class RecordDateInDatetime < ActiveRecord::Migration
  def self.up
    change_column :records, :date, :datetime
  end

  def self.down
    change_column :records, :date, :date
  end
end
