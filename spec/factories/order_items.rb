FactoryGirl.define do
  factory :order_item do
    book
    order
    quantity 5
  end
end
