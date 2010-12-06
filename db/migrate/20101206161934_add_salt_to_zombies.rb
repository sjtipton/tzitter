class AddSaltToZombies < ActiveRecord::Migration
  def self.up
    add_column :zombies, :salt, :string
  end

  def self.down
    remove_column :zombies, :salt
  end
end
