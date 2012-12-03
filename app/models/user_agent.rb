class UserAgent < ActiveRecord::Base

  attr_accessible :agent

  belongs_to :resource_request

  validates :agent, presence: true, uniqueness: true
  validates :resource_request, presence: true

end
