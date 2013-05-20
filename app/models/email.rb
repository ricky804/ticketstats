class Email < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :email, :customer_id
end
