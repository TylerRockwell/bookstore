FactoryGirl.define do
  factory :user, class: 'User' do
    sequence(:email) { |n| "user#{n}@example.com" }
    password              'password'
    password_confirmation 'password'
    stripe_customer_id    'cus_7tDRQQS0nrwl9A'
  end
end
