class Rtuser < ActiveRecord::Base
  OPEN_STATUS = ['new', 'open']
  CLOSE_STATUS = ['resolved', 'deleted', 'rejected']

  has_many :rttickets
  attr_accessor :tickets_count
  self.table_name = "users"
  establish_connection('rtdatabase')

  def self.open_tickets(user_id)
    scoped.where(creator: user_id, status: OPEN_STATUS).order('lastupdated desc')
  end

  def self.number_of_created_tickets(user_id)
    scoped.where(creator: user_id).count
  end

  def self.total_number_of_resolved_tickets(user_id)
    scoped.where(lastupdatedby: user_id, status: CLOSE_STATUS).count
  end

  def self.tickets_created_by_user(user_id)
    result = scoped.where(
      creator: user_id,
      created: (Time.now.midnight - 1.year)..Time.now.midnight
    ).group("DATE_FORMAT(Created, '%Y-%m')").count
  end

  def self.tickets_closed_by_user(user_id)
    result = scoped.where(
      lastupdatedby: user_id,
      created: (Time.now.midnight - 1.year)..Time.now.midnight,
      status: CLOSE_STATUS
    ).group("DATE_FORMAT(lastupdated, '%Y-%m')").count
  end

end






















