FactoryGirl.define do 
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'p@ssw0rd'
  end
end

