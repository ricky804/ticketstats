class Email < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :email, :customer_id

  validates :email, presence: true, uniqueness: true, format: {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, :message => "Invalid email format"}

  #This will generates an error when..new customer gets saved. 
  #validates :customer_id, presence: true
  #

  def draw_line_chart(lst_months, lst_data)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart( { defaultSeriesType: "spline" } )
      f.title( { text: "Tickets Created" } )
      f.series( type: "spline", name: "Ticket", data: lst_data)
      f.options[:xAxis][:categories] = lst_months
      f.options[:xAxis][:labels] = { rotation: -90, align: 'right', style: { fontSize: '10px'} }
      f.options[:yAxis][:title] = { text: "Number of Tickets" }
      f.legend( layout: 'vertical', align: 'right', verticalAlign: 'top', borderWidth: 0)
    end
  end
end
