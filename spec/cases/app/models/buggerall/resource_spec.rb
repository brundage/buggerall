require 'spec_helper'

describe Buggerall::Resource do

  it { should validate_presence_of :path }
  it { should validate_uniqueness_of :path }

end