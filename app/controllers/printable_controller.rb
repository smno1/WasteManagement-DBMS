class PrintableController < ApplicationController
  
  def site_month_invoice
    @companies=Company.all
    @sites=Site.none
  end
  
  def update_sites
    _company=Company.find(params[:company_id])
    @sites=_company.sites.map{|s| [s.site_name, s.id]}
  end
  
  def printable_pdf
    @site=Site.find_by_id params[:site_id]
    @month=date_select_to_date(params[:month])
    if @site.blank? || @month.blank?
      redirect_to site_month_invoice_path, :flash=> {:error => "please fulfill the required selection"}
    end
    @services=@site.services
  end
  
end
