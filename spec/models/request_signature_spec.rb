require 'spec_helper'

describe RequestSignature do

  it { should belong_to :resource_request }
  it { should have_one(:resource).through(:resource_request) }
  it { should have_one(:user_agent).through(:resource_request) }

  it { should validate_presence_of :remote_ip }

  it { should validate_presence_of :resource_request }
# it { should validate_uniqueness_of :resource_request_id }

end
