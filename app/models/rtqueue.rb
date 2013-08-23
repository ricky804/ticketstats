class Rtqueue < ActiveRecord::Base
  has_many :rttickets, foreign_key: "Queue"
  self.table_name = "queues"
  establish_connection('rtdatabase')
end
