# == Schema Information
#
# Table name: resource_requests
#
#  id                   :integer          not null, primary key
#  request_signature_id :integer          not null
#  resource_id          :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'spec_helper'

describe ResourceRequest do

#  it_behaves_like :working_in_the_factory do
#    let(:record) { FactoryGirl.build :resource_request }
#  end

  it { should belong_to :request_signature }
  it { should belong_to :resource }

  it { should validate_presence_of :request_signature }
  it { should validate_presence_of :resource }

end
