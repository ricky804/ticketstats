class Transaction < ActiveRecord::Base
  self.table_name = "transactions"
  establish_connection('rtdatabase')
end
