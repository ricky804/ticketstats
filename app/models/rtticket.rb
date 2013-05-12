class Rtticket < ActiveRecord::Base
  belongs_to :rtuser

  #Actual table name in RT database
  self.table_name = "tickets"
  
  #Establish connection
  establish_connection('rtdatabase')
end
