class AddedTableReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string   :name
      t.text     :content, :limit => 16777215
      t.string   :urlkey
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :reports
  end
end
