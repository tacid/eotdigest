class SourceFilterModel < ActiveRecord::Migration
  def self.up
    create_table :sfilters do |t|
      t.string   :name
      t.string   :filter
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :sfilters
  end
end
