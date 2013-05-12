class Rtuser < ActiveRecord::Base
  has_many :rtticket

  #Actual table name in RT database
  self.table_name = "users"

  #Establish connection
  establish_connection('rtdatabase')
end
