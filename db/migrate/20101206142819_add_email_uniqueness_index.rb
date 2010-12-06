class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :zombies, :email, :unique => true
  end

  def self.down
    remove_index :zombies, :email
  end
end
