require 'spec_helper'
describe HttpReferrer do
  it { should allow_mass_assignment_of :url }
  it { should have_many :resource_requests }
  it { should have_many(:request_signatures).through(:resource_requests) }
end
