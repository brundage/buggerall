# == Schema Information
#
# Table name: user_agents
#
#  id         :integer          not null, primary key
#  agent      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Resource do

  it_behaves_like :working_in_the_factory do
    let(:record) { FactoryGirl.build :user_agent }
  end

  it { should validate_presence_of :path }
  it { should validate_uniqueness_of :path }

end
