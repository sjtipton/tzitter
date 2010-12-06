class CreateZombies < ActiveRecord::Migration
  def self.up
    create_table :zombies do |t|
      t.string :name
      t.string :username
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :zombies
  end
end
