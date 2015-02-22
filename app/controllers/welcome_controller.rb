class WelcomeController < ApplicationController
  
  def portal
    unless current_user.company.nil?
      @sites=current_user.company.sites
    end
  end
  
  def update_pie_chart
    site=Site.find(params[:site_id])
    month=date_select_to_date(params[:month])
    baseline_data=site.baseline_data.sum(:monthly_charge)
    current_months=site.current_months.where(:month=>month).sum(:actual_month_charge)
    saving=baseline_data-current_months
    @pieChart=LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [20, 20, 30, 30]} )
          series = {
                   :type=> 'pie',
                   :name=> 'Money ',
                   :data=> [
                      ['Current Acutally Charge',  current_months.round(2)],
                      {
                         :name=> 'Saving Against Baseline',    
                         :y=> saving.round(2),
                         :sliced=> true,
                         :selected=> true,
                         :color=>'green'
                      }
                   ]
          }
          f.series(series)
          f.options[:tooltip][:valueSuffix] = '$'
          f.options[:title][:text] = "Site Saving "+month.strftime("%b %Y")
          f.options[:subtitle][:text] = "The whole pie is $"+baseline_data.round(2).to_s+" as the baseline cost"
          f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '5px',:top=> 'auto'}) 
          f.plot_options(:pie=>{
            :allowPointSelect=>true, 
            :cursor=>"pointer" , 
            :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
              }
            }
          })
    end
  end
  
  def update_line_chart
    site=Site.find(params[:site_id])
    from_month=date_select_to_date(params[:collection_date_from])
    to_month=date_select_to_date(params[:collection_date_to])
    baseline_data=site.baseline_data.sum(:monthly_charge)
    current_months=site.current_months.where(:month=>from_month..to_month)
    month_array=DataUtil.get_month_iter_array(from_month,to_month)
    data_array=Array.new
    baseline_array=Array.new
    month_array.each do |month|
      data_array<<current_months.where(:month=>month).sum(:actual_month_charge)
      baseline_array<<baseline_data
    end
    
    @lineChart=LazyHighCharts::HighChart.new('line') do |f|
      f.options[:title][:text] = "Site History Cost from "+from_month.strftime("%b %Y")+" to "+to_month.strftime("%b %Y")
      f.xAxis({
        :categories=>month_array.map {|date| [date.strftime("%b %Y")]}
        })
      f.series({
        :name=> 'current_month_cost',
        :data=>data_array
      }) 
      f.series({
        :name=> 'baseline_cost_reference',
        :data=>baseline_array,
        :color=>'red'
      }) 
      f.yAxis({
        :title=>{
          :text=>'Cost'
        }
      }) 
    end
  end
  
end
