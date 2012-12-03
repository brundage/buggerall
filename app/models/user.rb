class User < ActiveRecord::Base

  attr_accessible []

  has_many :resource_requests
  has_many :request_signatures, through: :resource_requests
  has_many :user_agents, through: :resource_requests


  def self.find_or_create!(args)
    id = args.delete(:id)
    return find id if id
    create! args
  end

end
