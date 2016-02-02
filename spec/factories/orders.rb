FactoryGirl.define do
  factory :order do
    user
    order_status
    total 0
  end
end
