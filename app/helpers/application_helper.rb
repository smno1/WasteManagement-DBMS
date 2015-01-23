module ApplicationHelper
  def sortable(column,title=nil)
    title ||= column.titleize
    css_class=column==sort_column ? "fa fa-sort-#{sort_direction}" : nil
    direction= column==sort_column&&sort_direction=="asc" ? "desc" : "asc"
    link_to title, {:sort=>column, :direction=>direction}, {:class=>css_class}
  end
  
  def float_pre_2 (number)
    number_with_precision(number,:precision=>2) 
  end
end
