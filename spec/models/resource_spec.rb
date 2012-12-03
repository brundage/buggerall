# == Schema Information
#
# Table name: resources
#
#  id   :integer          not null, primary key
#  path :string(255)
#

require 'spec_helper'

describe Resource do

  it_behaves_like :working_in_the_factory do
    let(:record) { FactoryGirl.build :resource }
  end

  it { should have_many :resource_requests }

  it { should validate_presence_of :path }
  it { should validate_uniqueness_of :path }

end
