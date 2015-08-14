class AddSupportOfSubcategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :parent_id, :integer

    add_index :categories, [:parent_id]
  end

  def self.down
    remove_column :categories, :parent_id

    remove_index :categories, :name => :index_categories_on_parent_id rescue ActiveRecord::StatementInvalid
  end
end
