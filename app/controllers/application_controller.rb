class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery

  def lst_closed_ticket
    closed_ticket_status = ["resolved", "deleted", "rejected"]
  end

  def draw_line_chart(hsh_ticket_created, hsh_ticket_closed)
    lst_open_tickets = Array.new
    lst_dates = hsh_ticket_created.keys().sort

    nujuck_created = Hash.new
    nujuck = 0

    lst_dates.each do |date|
      nujuck += hsh_ticket_created[date]
      nujuck_created[date] = nujuck
    end

    nujuck_closed = Hash.new
    nujuck2 = 0

    lst_dates.each do |date|
      nujuck2 += hsh_ticket_closed[date]
      nujuck_closed[date] = nujuck2
    end

    hsh_remain_tickets = Hash.new
    nujuck_created.each do |date, value|
      hsh_remain_tickets[date] = value - nujuck_closed[date]
    end

    lst_ticket_closed = hsh_ticket_closed.values()
    lst_ticket_created = hsh_ticket_created.values()
    lst_remain_tickets = hsh_remain_tickets.values()

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart( { defaultSeriesType: "spline" } )
      f.title( { text: "Ticket Status" } )
      f.series( type: "spline", name: "Created", data: lst_ticket_created)
      f.series( type: "spline", name: "Closed", data: lst_ticket_closed)
      f.series( type: "spline", name: "Open", data: lst_remain_tickets)
      f.options[:xAxis][:categories] = lst_dates
      f.options[:xAxis][:labels] = { rotation: -90, align: 'right', style: { fontSize: '10px'} }
      f.options[:yAxis][:title] = { text: "Number of Tickets" }
      f.legend( layout: 'vertical', align: 'right', verticalAlign: 'top', borderWidth: 0)
    end
  end
end

