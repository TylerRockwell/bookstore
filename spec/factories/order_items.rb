FactoryGirl.define do
  factory :order_item do
    book
    order
    quantity 1
  end
end
