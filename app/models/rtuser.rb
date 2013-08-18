class Rtuser < ActiveRecord::Base
  has_many :rttickets
  attr_accessor :tickets_count
  self.table_name = "users"
  establish_connection('rtdatabase')

  def close_status
    ['resolved', 'deleted', 'rejected']
  end

  def open_status
    ['new', 'open']
  end

  def open_tickets(user_id)
    Rtticket.where(creator: user_id, status: open_status).order('lastupdated desc')
  end

  def total_number_of_created_tickets(user_id)
    Rtticket.where(creator: user_id).count
  end

  def total_number_of_resolved_tickets(user_id)
    Rtticket.where(lastupdatedby: user_id, status: close_status).count
  end

  def tickets_created_by_user(user_id)
    result = Rtticket.where(
      creator: user_id,
      created: (Time.now.midnight - 1.year)..Time.now.midnight
    ).group("DATE_FORMAT(Created, '%Y-%m')").count
  end

  def tickets_closed_by_user(user_id)
    result = Rtticket.where(
      lastupdatedby: user_id,
      created: (Time.now.midnight - 1.year)..Time.now.midnight,
      status: close_status
    ).group("DATE_FORMAT(lastupdated, '%Y-%m')").count
  end

end






















