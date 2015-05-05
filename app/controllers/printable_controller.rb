class PrintableController < ApplicationController
  
  def site_month_invoice
    if is_admin?
      @companies=Company.all
      @sites=Site.none
    else
      @sites=current_user.company.sites unless current_user.company.blank?
    end
  end
  
  def update_sites
    _company=Company.find(params[:company_id])
    @sites=_company.sites.order(:site_name).map{|s| [s.site_name, s.id]}
  end
  
  def printable_pdf
    @site=Site.find_by_id params[:site_id]
    @month=date_select_to_date(params[:month])
    if @site.blank? || @month.blank? 
      redirect_to site_month_invoice_path, :flash=> {:error => "please fulfill the required selection"}
    else
      @services=@site.services
      @commentaries=@site.commentaries.where(:month=>@month)
    end
  end
  
end
