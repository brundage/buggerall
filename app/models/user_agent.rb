# == Schema Information
#
# Table name: user_agents
#
#  id         :integer          not null, primary key
#  agent      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserAgent < ActiveRecord::Base

  attr_accessible :agent

  has_many :request_signatures
  has_many :resource_requests, through: :request_signatures

  validates :agent, presence: true, uniqueness: true

end
