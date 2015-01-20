class DataSearchController < ApplicationController
  
  def company_search
    @q=Company.new
  end
  
end
