class AddUsernameUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :zombies, :username, :unique => true
  end

  def self.down
    remove_index :zombies, :username
  end
end
