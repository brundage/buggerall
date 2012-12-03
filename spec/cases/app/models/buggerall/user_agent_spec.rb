require 'spec_helper'

describe Buggerall::UserAgent do

  it { should belong_to :resource_request }
  it { should validate_presence_of :resource_request }

  it { should validate_presence_of :agent }
#  it { should validate_uniqueness_of :agent }

end
