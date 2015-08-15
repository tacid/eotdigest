class ChangeAllGlobalAndLocalEditorsToEditor < ActiveRecord::Migration
  def self.up
    User.where(role: %w(local_editor global_editor)).each{ |u| u.role = :editor; u.save }
  end

  def self.down
    User.where(role: :editor).each{ |u| u.role = :local_editor; u.save }
    User.where(administrator: true).each{ |u| u.role = :global_editor; u.save }
  end
end
