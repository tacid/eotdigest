class AddedModelsCategoryAndRecord < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.date     :date
      t.text     :content
      t.text     :source
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :category_id
    end
    add_index :records, [:category_id]

    create_table :categories do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :records
    drop_table :categories
  end
end
