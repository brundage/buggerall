class UserAgent < ActiveRecord::Base

  attr_accessible :agent

  validates :agent, presence: true, uniqueness: true

end
