class Visitor < ActiveRecord::Base

  has_many :request_signatures
  has_many :resource_requests, through: :request_signatures

  def self.find_or_create!(args)
    id = args.delete(:id)
    return find id if id
    create! args
  end


  def last_request_signature
    request_signatures.last
  end

end
