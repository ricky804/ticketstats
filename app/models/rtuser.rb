class Rtuser < ActiveRecord::Base
  #Make sure it is rtticket"s" not rtticket
  has_many :rttickets

  #Actual table name in RT database
  self.table_name = "users"

  #Establish connection
  establish_connection('rtdatabase')
end
