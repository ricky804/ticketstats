class RtqueuesController < ApplicationController
  def index
    @rtqueues = Rtqueue.all(order: "Name")
  end

  def show
    @rtqueue = Rtqueue.find(params[:id])
    @open_tickets = @rtqueue.rttickets.where(status: Rtticket.open_status).order('LastUpdated desc').all
    @lst_data = Array.new
    @rtqueue.rttickets.count(group: "Status").each do |status, count|
      @lst_data << [status, count]
    end
    @queue_chart = pie_chart(@lst_data, @rtqueue.Name, 'Ticket')

    @hsh_count_by_requestor = Hash.new
    @rtqueue.rttickets.count(group: 'creator', order: 'count_all desc', limit: 10).each do |user_id, count|
      @hsh_count_by_requestor[Rtuser.find(user_id).EmailAddress] = count
    end
    @chart_by_requestor = bar_chart(@hsh_count_by_requestor, 'Top 10 Requestors', 'blue', 'Tickets')
  end

  def new
  end

end
