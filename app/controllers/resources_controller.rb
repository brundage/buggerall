class ResourcesController < ApplicationController

  def index
    @resources = Resource.includes(:resource_requests).all
  end

end
