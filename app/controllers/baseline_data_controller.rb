class BaselineDataController < ApplicationController

  def index
    @BaselineData.all
  end

end