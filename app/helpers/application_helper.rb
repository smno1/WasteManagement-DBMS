module ApplicationHelper
  def sortable(column,title=nil)
    title ||= column.titleize
    css_class=column==sort_column ? "fa fa-sort-#{sort_direction}" : nil
    direction= column==sort_column&&sort_direction=="asc" ? "desc" : "asc"
    link_to title, params.merge(:sort=>column, :direction=>direction,:page=>nil), {:class=>css_class}
  end
  
  def float_pre_2 (number)
    number_with_precision(number,:precision=>2) 
  end
  
  def number_to_us_currency(number)
    number_to_currency(number_with_precision(number,:precision=>2),:unit=>'$')
  end
  
  def number_with_percentage(number)
    number_to_currency(number,:unit=>"%",:format=>"%n%u")
  end
  
end
