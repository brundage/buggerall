FactoryGirl.define do

  sequence :path do |n|
    "/blark/#{n}"
  end

  factory :resource do
    path { FactoryGirl.generate :path }
  end

end

