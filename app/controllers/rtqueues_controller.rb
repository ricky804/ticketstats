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
    lst_data = Array.new
    hsh_ticket_counts.each do |status, count|
      lst_data << [status, count]
    end

    @chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart( { :defaultSeriesType=>"pie", height: 500 } )
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
    @lst_ticket_counts_by_email = @rtqueue.rttickets.count(group: "Creator").sort_by{ |creator, count| count }.reverse
    @email_and_count = Hash.new
    @lst_ticket_counts_by_email[0..30].each do | id_count |
      rtuser = Rtuser.find_by_id(id_count[0])
      #rtuser = Rtuser.where(id: id_count[0]) this does not work, it returns active relation rather than ractive record
      if !rtuser.blank? and !rtuser.EmailAddress.blank?
        @email_and_count[rtuser.EmailAddress] = id_count[1]
      end
    end
  end

  def new
  end

end
