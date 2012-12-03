# == Schema Information
#
# Table name: resource_requests
#
#  id                   :integer          not null, primary key
#  request_signature_id :integer          not null
#  resource_id          :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ResourceRequest < ActiveRecord::Base

  belongs_to :request_signature
  belongs_to :resource

  validates :request_signature, presence: true
  validates :resource, presence: true

end
