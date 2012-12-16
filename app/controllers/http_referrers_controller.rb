class HttpReferrersController < ApplicationController
  def index
    @http_referrers = HttpReferrer.all
  end
end
