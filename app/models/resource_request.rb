class ResourceRequest < ActiveRecord::Base

  belongs_to :request_signature
  belongs_to :resource

  validates :request_signature, presence: true
  validates :resource, presence: true

end
