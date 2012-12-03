FactoryGirl.define do

  sequence :accept_charset do |n|; "utf-#{n}"; end

  factory :request_signature do
    accept_charset { FactoryGirl.generate :accept_charset }
    remote_ip '127.18.92.254'

    after :build do |rs|
      rs.user_agent = FactoryGirl.build :user_agent
    end

    before :create do |rs|
      rs.user_agent.new_record? && rs.user_agent.save
    end
  end

end
