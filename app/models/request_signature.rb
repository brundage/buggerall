# == Schema Information
#
# Table name: request_signatures
#
#  id              :integer          not null, primary key
#  accept          :string(255)
#  accept_charset  :string(255)
#  accept_encoding :string(255)
#  accept_language :string(255)
#  checksum        :string(128)      not null
#  remote_ip       :string(15)       not null
#  user_agent_id   :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class RequestSignature < ActiveRecord::Base

  CHECKSUM_ATTRIBUTE_NAMES = [ 'accept',
                               'accept_charset',
                               'accept_encoding',
                               'accept_language',
                               'remote_ip',
                               'user_agent'
                             ]

  attr_accessible :accept, :accept_charset, :accept_encoding, :accept_language,
                  :remote_ip, :request_uuid, :user_agent

  before_validation :generate_checksum, on: :create

  belongs_to :user_agent

  has_many :resource_requests

  validates :checksum, length: { is: 128 }, presence: true, uniqueness: true
  validates :remote_ip, length: { maximum: 15 }, presence: true
  validates :user_agent, presence: true


  def self.checksum_attribute_names; CHECKSUM_ATTRIBUTE_NAMES; end


  def self.find_or_create_by_request!(args)
    request = args.delete(:request)
    attrs = checksum_attribute_names.inject({}) do |hash,name|
                                                  hash[name] = request.send name
                                                  hash
                                                end
    checksum = generate_checksum(attrs)
    return find_by_checksum checksum if exists?(checksum: checksum)
    attrs.merge!(args)
    create! attrs
  end


  def self.generate_checksum(attrs, digester=Digest::SHA3)
    digester.hexdigest attrs.values_at(checksum_attribute_names).collect(&:to_s).join("").downcase
  end


  def generate_checksum
    self.checksum ||= self.class.generate_checksum(checksum_attributes)
  end

private

  def checksum_attributes
    attributes.slice(*self.class.checksum_attribute_names).merge(extra_checksum_attributes)
  end


  def extra_checksum_attributes
    return { } unless user_agent
    { 'user_agent' => user_agent.agent }
  end

end
