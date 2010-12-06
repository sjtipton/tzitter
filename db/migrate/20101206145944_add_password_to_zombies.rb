class AddPasswordToZombies < ActiveRecord::Migration
  def self.up
    add_column :zombies, :encrypted_password, :string
  end

  def self.down
    remove_column :zombies, :encrypted_password
  end
end
