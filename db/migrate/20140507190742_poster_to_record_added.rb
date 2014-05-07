class PosterToRecordAdded < ActiveRecord::Migration
  def self.up
    change_column :users, :role, :string, :limit => 255, :default => :viewer

    add_column :records, :poster_id, :integer

    add_index :records, [:poster_id]
  end

  def self.down
    change_column :users, :role, :string, default: "viewer"

    remove_column :records, :poster_id

    remove_index :records, :name => :index_records_on_poster_id rescue ActiveRecord::StatementInvalid
  end
end
