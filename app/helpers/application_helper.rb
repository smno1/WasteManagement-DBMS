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
  def is_admin?
    return current_user.present? && current_user.has_role?(:admin)
  end
  def number_to_us_currency(number)
    number_to_currency(number_with_precision(number,:precision=>2),:unit=>'$')
  end
  
  def number_with_percentage(number)
    number_to_currency(number*100,:unit=>"%",:format=>"%n%u")
  end
  
  def info_from_service(sid)
    unless sid.blank?
      sv=Service.find(sid)
      content_tag(:h4,"Client name: "+(sv.site.company.client_name||""))+
      content_tag(:h4,"Site name: "+(sv.site.site_name||""))+
      content_tag(:h4,"Service: "+(sv.account_number_and_name||"")+" "+(sv.description||"")+" "+(sv.service_type||""))+content_tag(:div,nil,:class=>"line-separator")
    end  
  end
  
  def info_from_site(sid)
    unless sid.blank?
      _site=Site.find(sid)
      content_tag(:h4,"Client name: "+(_site.company.client_name||""))+
      content_tag(:h4,"Site name: "+(_site.site_name||""))+content_tag(:div,nil,:class=>"line-separator")
    end
  end
  
  def info_from_company(sid)
    unless sid.blank?
      content_tag(:h4,"Client name: "+Company.find(sid).client_name||"")+content_tag(:div,nil,:class=>"line-separator")
    end
  end
  
  def site_select_tag(sites,promot="")
      select_tag :site_id, options_from_collection_for_select(sites,'id','site_name',params[:site_id]),
    :prompt => promot, :default => nil,:id=>'site_select'
  end
  
  def month_select_tag(start_year=2000)
     date_select :month,'date', 
      {:discard_day=>true,:include_blank => true, :default => nil,:start_year=>start_year}
  end
  
  def month_duration_select_tag(start_year=1990)
   date_select( :collection_date_from,'date',
  {:include_blank => true, :default => nil,:start_year=>start_year,:discard_day=>true})  + content_tag(:div," to ",:class=>"inline")+
   date_select( :collection_date_to,'date',
  {:include_blank => true, :default => nil,:start_year=>start_year,:discard_day=>true}) +content_tag(:div,"(Default month: Jan)",:class=>"inline")
  end
  
  def page_header(text)
    content_for(:page_header) { text.to_s }
  end
end
