module Buggerall
  class RequestSignature < ActiveRecord::Base

    attr_accessible :accept, :accept_charset, :accept_encoding,
                    :accept_language, :remote_ip, :request_uuid

    belongs_to :resource_request
    has_one :resource, through: :resource_request
    has_one :user_agent, through: :resource_request

    validates :remote_ip, presence: true

    validates :resource_request, presence: true
    validates :resource_request_id, uniqueness: true


    def self.create_by_request!(args)
      request = args.delete(:request)
      attrs = { accept: request.accept,
                accept_charset: request.accept_charset,
                accept_encoding: request.accept_encoding,
                accept_language: request.accept_language,
                remote_ip: request.remote_ip.to_s,
                request_uuid: { request: request }
              }
      create! attrs
    end


    def request_uuid=(args)
      args[:rr_class] ||= ResourceRequest
      self.resource_request = args[:rr_class].find_or_create_by_request(request: args[:request])
      resource_request
    end

  end
end
