class Rtticket < ActiveRecord::Base
  OPEN_STATUS = ['new', 'open']
  CLOSE_STATUS = ['resolved', 'deleted', 'rejected']

  belongs_to :rtuser, foreign_key: "Creator"
  belongs_to :rtqueue, foreign_key: "Queue"
  belongs_to :requestor, primary_key: "Creator", foreign_key: "rtuser_id"
  has_many :favorites, foreign_key: "ticket_id"
  has_many :transactions, foreign_key: "ObjectId"
  self.table_name = "tickets"
  establish_connection('rtdatabase')

  def self.open_tickets(user_id)
    scoped.where(creator: user_id, status: OPEN_STATUS).order('lastupdated desc')
  end

  def self.total_number_of_open_tickets(user_id)
    scoped.where(creator: user_id, status: OPEN_STATUS).count
  end

  def self.total_number_of_created_tickets(user_id)
    scoped.where(creator: user_id).count
  end

  def self.total_number_of_resolved_tickets(user_id)
    scoped.where(lastupdatedby: user_id, status: CLOSE_STATUS).count
  end

  def self.tickets_created_by_user(user_id)
    scoped.where(
      creator: user_id,
      created: (Time.now.midnight - 1.year)..Time.now.midnight
    ).group("DATE_FORMAT(Created, '%Y-%m')").count
  end

  def self.tickets_closed_by_user(user_id)
    scoped.where(
      lastupdatedby: user_id,
      created: (Time.now.midnight - 1.year)..Time.now.midnight,
      status: CLOSE_STATUS
    ).group("DATE_FORMAT(lastupdated, '%Y-%m')").count
  end

  def favorited?(user_id, ticket_id)
    favorites.where(user_id: user_id, ticket_id: ticket_id).exists?
  end

end
