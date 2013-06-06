class RtqueuesController < ApplicationController
  def index
    @rtqueues = Rtqueue.all(order: "Disabled")
    hsh_ticket_created = Hash.new

    @rtqueues.each do |q|
      hsh_ticket_created[q.Name] = q.rttickets.count()
    end

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart( { defaultSeriesType: "bar", height: 3000} )
      f.title( { text: "RT Queues" } )
      f.series( name: "Tickets", data: hsh_ticket_created.values())
      f.options[:xAxis][:categories] = hsh_ticket_created.keys()
      f.options[:yAxis][:title] = { text: "Number of Tickets" }
      f.options[:plotOptions][:bar] = { dataLabels: {enabled:true} }
    end
  end

  def show
    @rtqueue = Rtqueue.find(params[:id])
    hsh_ticket_counts = @rtqueue.rttickets.count(group: "Status")
    @open_tickets = @rtqueue.rttickets.where(Status: "open").all
    lst_data = Array.new
    hsh_ticket_counts.each do |status, count|
      lst_data << [status, count]
    end

    @chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart( { defaultSeriesType: "pie", height: 500 } )
      series = {
        type: 'pie',
        name: 'Num of tickets',
        data: lst_data,
      }
      f.series(series)
      f.options[:title][:text] = "Ticket Status"
      f.legend(layout: 'vertical', style: { left: 'auto', bottom: 'auto', right: '50px', top: '100px'} )
      f.plot_options(
        pie: {
          allowPointSelect: true,
          cursor: "pointer",
          showInLegend: true,
          dataLabels: {
            enabled: true,
            color: "black",
            style: { font: "13px Trebuchet MS, Verdana, sans-serif" }
          }
        }
      )
    end

    tickets_count_by_user_id = Hash[@rtqueue.rttickets.count(group: "Creator").sort_by{ |creator, count| -count }.first(20)]
    @users = Rtuser.where(id: tickets_count_by_user_id.keys)
    email_and_count = Hash.new
    @users.each do |user|
      user.tickets_count = tickets_count_by_user_id[user.id]
      email_and_count[user.EmailAddress] = user.tickets_count
    end
    @chart_ticket_count_by_email = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart( { height: "500", marginLeft: "100" } )
      f.title( { text: "Top 20 Requestor" } )
      f.options[:xAxis][:categories] = email_and_count.keys
      f.options[:xAxis][:labels] = { rotation: -30, align: 'right', style: { fontSize: '10px'} }
      f.series(type: 'column', name: 'Ticket Count', data: email_and_count.values)
      f.plot_options(
        column: {
          dataLabels: { enabled: true }
        }
      )
    end
  end

  def new
  end

end
