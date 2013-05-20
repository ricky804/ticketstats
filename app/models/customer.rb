class Customer < ActiveRecord::Base
  attr_accessible :name
  has_many :tickets
  has_many :emails
end
