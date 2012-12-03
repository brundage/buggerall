module Buggerall
  class UserAgent < ActiveRecord::Base

    attr_accessible :agent

    belongs_to :resource_request

    validates :resource_request, presence: true
    validates :agent, presence: true, uniqueness: true

  end
end
