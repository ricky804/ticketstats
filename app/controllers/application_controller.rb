class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery

  def bar_chart(hsh_data, title, color, legend)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart({ defaultSeriesType: "bar", borderWidth: 0, height: 400, margin: [70, 10, 80, 200] })
      f.title({ align: "left", text: title, margin: 100, style: { fontSize: '14px', fontFamily: 'verdana', fontWeight: 'bold' }})
      f.options[:xAxis][:categories] = hsh_data.keys()
      f.series(type: 'bar', name: legend, color: color, data: hsh_data.values())
      f.legend( layout: 'vertical', align: 'right', verticalAlign: 'top', borderWidth: 1)
    end
  end

  def line_chart(hsh_data, title, color, legend)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.chart({ defaultSeriesType: "spline", borderWidth: 0, height: 300, margin: [70, 0, 80, 40] })
      f.title({ align: "left", text: title, margin: 100, style: { fontSize: '14px', fontFamily: 'verdana', fontWeight: 'bold' }})
      f.series( type: "spline", name: legend, color: color, data: hsh_data.values())
      f.options[:xAxis][:categories] = hsh_data.keys()
      f.options[:xAxis][:labels] = { rotation: 0, align: 'center', style: { fontSize: '10px'} }
      f.legend( layout: 'horizontal', align: 'right', verticalAlign: 'top', borderWidth: 1)
    end
  end

  def combined_chart(hsh_data1, data1_label, hsh_data2, data2_label, title)
    LazyHighCharts::HighChart.new('graph') do |f|
      lst_dates = hsh_data1.keys()
      lst_dates2 = hsh_data2.keys()
      lst_dates2.each do |date|
        if not lst_dates.include? date
          lst_dates << date
        end
        lst_dates.sort
      end

      lst_sum = Array.new
      lst_data1 = Array.new
      lst_data2 = Array.new

      lst_dates.each do |date|
        lst_data1 << hsh_data1[date].to_i
        lst_data2 << hsh_data2[date].to_i
        lst_sum << hsh_data1[date].to_i + hsh_data2[date].to_i
      end

      f.series( type: 'column', name: data1_label, data: lst_data1 )
      f.series( type: 'column', name: data2_label, data: lst_data2 )
      f.series( type: 'spline', name: "All", data: lst_sum )
      f.chart({ borderWidth: 0, height: 360, margin: [70, 0, 80, 40] })
      f.title({ align: "left", text: title, margin: 100, style: { fontSize: '14px', fontFamily: 'verdana', fontWeight: 'bold' }})
      f.options[:xAxis][:categories] = lst_dates
      f.options[:xAxis][:labels] = { rotation: 0, align: 'center', style: { fontSize: '10px'} }
      f.legend( layout: 'horizontal', align: 'center', verticalAlign: 'bottom', borderWidth: 1)
    end
  end

  def pie_chart(lst_data, title, legend)
    LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({ defaultSeriesType: "pie", height: 350, width: 600, borderWidth: 1, margin: [15, 150, 10, 10] })
      f.title({ align: "left", text: title, margin: 100, style: { fontSize: '14px', fontFamily: 'verdana', fontWeight: 'bold' }})
      f.series( type: 'pie', name: legend, data: lst_data )
      f.legend( layout: 'vertical', verticalAlign: 'top', align: 'right', floating: true)
      f.plot_options(
        pie: {
          allowPointSelect: true,
          cursor: "pointer",
          showInLegend: true,
          dataLabels: {
            enabled: true,
            color: "black",
            format: "{point.name} {point.percentage:.1f}%"
          }
        }
      )
    end
  end
end

