class Resource < ActiveRecord::Base

  attr_accessible :path

  has_many :resource_requests

  validates :path, presence: true, uniqueness: true

end
