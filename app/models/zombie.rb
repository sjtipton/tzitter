# == Schema Information
# Schema version: 20101206133050
#
# Table name: zombies
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  username   :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Zombie < ActiveRecord::Base
  attr_accessible :name, :username, :email

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                   :length => { :maximum => 50 }
  validates :username, :presence => true,
                       :length => { :minimum => 8,
                                    :maximum => 16 },
                       :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
end
