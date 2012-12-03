require 'spec_helper'

describe Resource do

  it_behaves_like :working_in_the_factory do
    let(:record) { FactoryGirl.build :user_agent }
  end

  it { should validate_presence_of :path }
  it { should validate_uniqueness_of :path }

end
