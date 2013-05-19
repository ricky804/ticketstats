class Favorite < ActiveRecord::Base
  belongs_to :rtticket, :foreign_key => "ticket_id"
  validates :ticket_id, :presence => true
  attr_accessible :user_id, :ticket_id, :note, :tag
end
