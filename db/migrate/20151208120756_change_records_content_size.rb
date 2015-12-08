class ChangeRecordsContentSize < ActiveRecord::Migration
  def change
      change_column :records, :content, :text, :limit => 16777215
  end
end
