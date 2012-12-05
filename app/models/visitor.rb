class Visitor < ActiveRecord::Base

  has_many :request_signatures

  def self.find_or_create!(args)
    id = args.delete(:id)
    return find id if id
    create! args
  end

end
