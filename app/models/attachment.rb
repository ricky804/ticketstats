class Attachment < ActiveRecord::Base
  self.table_name = "attachments"
  establish_connection("rtdatabase")
  belongs_to :transactions

  scope :text_only, -> {where contenttype: ['text/plain', 'text/html']}
end
