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

  attr_accessible :dnt, :http_referrer, :request_signature, :resource, :uuid

  belongs_to :http_referrer
  belongs_to :request_signature
  belongs_to :resource

  scope :untracked, where(dnt: true)
  scope :tracked, where(dnt: false)

  validates :dnt, presence: true
  validates :request_signature, presence: true
  validates :resource, presence: true
  validates :uuid, presence: true, uniqueness: true

end
