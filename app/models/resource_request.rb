class ResourceRequest < ActiveRecord::Base

  attr_accessible :http_referer, :remote_ip, :url, :request_uuid, :resource,
                  :user, :user_agent, :user_agent_string

  belongs_to :resource
  belongs_to :user
  belongs_to :user_agent

  has_one :request_signature

  validates :resource, presence: true
  validates :user, presence: true
  validates :user_agent, presence: true

  def self.find_or_create_by_request(args)
    request = args.delete(:request)
    return unless request
    return find_by_request_uuid(request.uuid) if exists?(request_uuid: request.uuid)
    attrs = {
              http_referer: request.env['HTTP_REFERER'].to_s,
              remote_ip: request.remote_ip.to_s,
              request_uuid: request.uuid.to_s,
              url: { url: request.original_fullpath },
              user_agent_string: { agent: request.user_agent }
            }.merge(args)
    attrs.delete(:user_agent_string) if args[:user_agent]
    attrs.delete(:url) if args[:resource]
    create! attrs
  end


#  def url=(args)
#    args[:resource_class] ||= Resource
#    self.resource = args[:resource_class].find_or_create_by_path args[:url]
#  end


  def user_agent_string=(args)
    args[:ua_class] ||= UserAgent
    self.user_agent = args[:ua_class].find_or_create_by_agent args[:agent]
  end



end
