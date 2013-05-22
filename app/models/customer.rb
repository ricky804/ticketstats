class Customer < ActiveRecord::Base
  attr_accessible :name
  has_many :tickets, :dependent => :destroy
  has_many :emails, :dependent => :destroy
  validates :name, presence: true, uniqueness: true
end
