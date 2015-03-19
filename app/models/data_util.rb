class DataUtil
  # should be mixed into the Date class
  def self.count_number_of_month_between_dates(from_date,to_date)
    (to_date.year*12+to_date.month) - (from_date.year*12+from_date.month)
  end
  
  def self.get_month_iter_array(from_date,to_date)
    months_count=self.count_number_of_month_between_dates(from_date,to_date)
    month_array=months_count.times.each_with_object([]) do |count,array|
      array<<from_date+count.months
    end
    return month_array
  end
  
  def self.get_current_fy_start_date
    today=Date.today
    july=Date.new(today.year,7,1)
    today<july ? july.last_year : july
  end
  
  def self.get_fy_duration fy
    return Date.new(fy-1,7,1),Date.new(fy,7,1)
  end
  
  def self.get_current_financial_year
    today=Date.today
    today.month.to_i>7 ? today.year.to_i+1 :today.year.to_i    
  end
end