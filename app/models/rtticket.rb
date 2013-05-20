class Rtticket < ActiveRecord::Base
  #Relation between rtuser and rtticket. Table that has foreign_key is always 'belongs_to'. Default foreign_key is "_id"
  #So this case it default key was "rtuser_id"
  belongs_to :rtuser, :foreign_key => "Creator"

  has_many :favorites
  has_many :transactions

  #Actual table name in RT database
  self.table_name = "tickets"
  
  #Establish connection
  establish_connection('rtdatabase')
end
