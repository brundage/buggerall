require 'spec_helper'

describe Buggerall::ResourceRequest do

  it { should belong_to(:resource) }
  it { should belong_to(:user_agent) }
  it { should have_one :request_signature }

  it { should validate_presence_of :resource }
  it { should validate_presence_of :user_agent }

end
