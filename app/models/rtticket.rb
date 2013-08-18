class Rtticket < ActiveRecord::Base
  #Relation between rtuser and rtticket. Table that has foreign_key is always 'belongs_to'. Default foreign_key is "_id"
  #So this case it default key was "rtuser_id"
  belongs_to :rtuser, foreign_key: "Creator"
  belongs_to :rtqueue, foreign_key: "Queue"
  has_many :favorites, foreign_key: "ticket_id"
  has_many :transactions, foreign_key: "ObjectId"

  self.table_name = "tickets"
  establish_connection('rtdatabase')

  def favorited?(user_id, ticket_id)
    favorites.where(user_id: user_id, ticket_id: ticket_id).exists?
  end

end
