class RequestSignaturesController < ApplicationController

  def index
    @request_signatures = RequestSignature.includes([:user_agent,:resource_requests]).all
  end

end
