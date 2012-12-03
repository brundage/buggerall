FactoryGirl.define do

  sequence :user_agent_string do |n|
    "factory girl #{n}"
  end

  factory :user_agent do
    agent { FactoryGirl.generate :user_agent_string }
  end

end

