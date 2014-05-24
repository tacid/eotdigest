class AddRegionKeyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :region_id, :integer

    add_index :users, [:region_id]
  end

  def self.down
    remove_column :users, :region_id

    remove_index :users, :name => :index_users_on_region_id rescue ActiveRecord::StatementInvalid
  end
end
