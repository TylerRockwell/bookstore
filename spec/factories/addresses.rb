FactoryGirl.define do
  factory :address do
    street_number   { rand(1..10000) }
    street_name     { Faker::Address.street_name }
    city            { Faker::Address.city }
    state           { Faker::Address.state_abbr }
    zip             { Faker::Address.zip }
    order
  end
end
