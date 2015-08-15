class ChangeAllGlobalAndLocalEditorsToEditor < ActiveRecord::Migration
  def self.up
    User.where(role: %w(local_editor global_editor)).each{ |u| u.role = :editor; u.save }
  end

  def self.down
  end
end
