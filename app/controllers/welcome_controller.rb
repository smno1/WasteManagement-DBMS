class WelcomeController < ApplicationController
  
  def portal
    unless current_user.company.nil?
      @column_headers=['site_name','site_address','number_of_service','client_company','running_total','waste_company','region','current_FY_saving']
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
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 20, 30, 30]} )
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
          f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '5px',:top=> '5px'}) 
          f.plot_options(:pie=>{
            :allowPointSelect=>true, 
            :cursor=>"pointer" , 
            :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
              },
              :format=>'<b>{point.name}</b>: {point.percentage:.1f} %'
            }
          })
    end
  end
  
  def update_line_chart
    site=Site.find(params[:site_id])
    from_month=date_select_to_date(params[:collection_date_from])
    to_month=date_select_to_date(params[:collection_date_to])
    baseline_data=site.baseline_data.sum(:monthly_charge).round(2)
    current_months=site.current_months.where(:month=>from_month..to_month)
    month_array=DataUtil.get_month_iter_array(from_month,to_month)
    data_array=Array.new
    baseline_array=Array.new
    month_array.each do |month|
      data_array<<current_months.where(:month=>month).sum(:actual_month_charge).round(2)
      baseline_array<<baseline_data
    end
    
    @lineChart=LazyHighCharts::HighChart.new('line') do |f|
      f.options[:title][:text] = "Site History Cost from "+from_month.strftime("%b %Y")+" to "+to_month.strftime("%b %Y")
      f.xAxis({
        :categories=>month_array.map {|date| [date.strftime("%b %Y")]}
        })
      f.tooltip({
        :valueSuffix=>'$'
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
  
  def update_comparison_line_chart
    site=Site.find(params[:site_id])
    from_month=date_select_to_date(params[:collection_date_from])
    to_month=date_select_to_date(params[:collection_date_to])
    from_month_2=date_select_to_date(params[:collection_date_from_2])
    to_month_2=date_select_to_date(params[:collection_date_to_2])
    
    baseline_data=site.baseline_data.sum(:monthly_charge).round(2)
    data_array=get_data_array(from_month,to_month,site)
    data_array_2=get_data_array(from_month_2,to_month_2,site)
    baseline_array=Array.new
    month_array=[DataUtil.count_number_of_month_between_dates(from_month,
      to_month),DataUtil.count_number_of_month_between_dates(from_month_2,to_month_2)].max
    month_array.times do 
      baseline_array<<baseline_data
    end
    
    @c_line_chart=LazyHighCharts::HighChart.new('line') do |f|
      f.options[:title][:text] = "Cost comparison between "+from_month.strftime("%b %Y")+" - "+to_month.strftime("%b %Y")+" and "+
        from_month_2.strftime("%b %Y")+" - "+to_month_2.strftime("%b %Y")
      f.plot_options({
        :line=>{
          :dataLabels=>{
            :enabled=>true,
            #:format=>'<b>{point.name}</b>: {point.percentage:.1f} %'
          }
        }
      })
      f.tooltip({
        :valueSuffix=>'$'
      })
      f.series({
        :name=> from_month.strftime("%b %Y")+" - "+to_month.strftime("%b %Y")+" cost",
        :data=>data_array
      }) 
      f.series({
        :name=> from_month_2.strftime("%b %Y")+" - "+to_month_2.strftime("%b %Y")+" cost",
        :data=>data_array_2
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
  private
  def get_data_array(from_month,to_month,site)
    current_months=site.current_months.where(:month=>from_month..to_month)
    month_array=DataUtil.get_month_iter_array(from_month,to_month)
    data_array=Array.new
    month_array.each do |month|
      data_array<<current_months.where(:month=>month).sum(:actual_month_charge).round(2)
    end
    return data_array
  end
end
