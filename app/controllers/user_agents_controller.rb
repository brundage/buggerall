class UserAgentsController < ApplicationController

  def index
    @user_agents = UserAgent.includes([:request_signatures,:resource_requests]).all
  end

end
