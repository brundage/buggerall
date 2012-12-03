class RequestSignature < ActiveRecord::Base

  attr_accessible :accept, :accept_charset, :accept_encoding, :accept_language,
                  :remote_ip, :request_uuid

  before_validation :generate_checksum, on: :create

  belongs_to :user_agent

  has_many :resource_requests

  validates :checksum, length: { is: 128 }, presence: true, uniqueness: true
  validates :remote_ip, length: { maximum: 15 }, presence: true
  validates :user_agent, presence: true


  def self.create_by_request!(args)
    request = args.delete(:request)
    attrs = { accept: request.accept,
              accept_charset: request.accept_charset,
              accept_encoding: request.accept_encoding,
              accept_language: request.accept_language,
              remote_ip: request.remote_ip.to_s
            }
    create! attrs
  end


  def self.generate_checksum(attrs, digester=Digest::SHA3)
    digester.hexdigest attrs.values_at(:accept_charset, :remote_ip).collect(&:to_s).join("").downcase
  end


  def generate_checksum
    self.checksum ||= self.class.generate_checksum(attributes)
  end

end
