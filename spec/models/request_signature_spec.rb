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

require 'spec_helper'

describe RequestSignature do

  it_behaves_like :working_in_the_factory do
    let(:record) { FactoryGirl.build :request_signature }
  end

  context 'shoulda stuff' do
    let(:request_signature) { FactoryGirl.build :request_signature }

    it { request_signature.should have_many :resource_requests }
    it { request_signature.should belong_to :visitor }
    it { request_signature.should belong_to :user_agent }

    it { request_signature.should validate_presence_of :remote_ip }
    it { request_signature.should validate_presence_of :user_agent }

    it { request_signature.should ensure_length_of(:checksum).is_equal_to(128) }
    it { request_signature.should ensure_length_of(:remote_ip).is_at_most(15) }

#    it { request_signature.should validate_uniqueness_of :checksum }
  end

end
