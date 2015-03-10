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
  
end