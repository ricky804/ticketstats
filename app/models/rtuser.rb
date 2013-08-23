class Rtuser < ActiveRecord::Base
  has_many :rttickets
  self.table_name = "users"
  establish_connection('rtdatabase')
end






















