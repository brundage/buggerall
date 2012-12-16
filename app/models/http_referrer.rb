class HttpReferrer < ActiveRecord::Base
  attr_accessible :url
  has_many :resource_requests
  has_many :request_signatures, through: :resource_requests
end
