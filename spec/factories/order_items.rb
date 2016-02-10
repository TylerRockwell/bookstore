FactoryGirl.define do
  factory :order_item do
    book_title 'Working Title'
    order
    quantity 1
    trait :complete do
      unit_price 10
      total_price { unit_price * quantity }
    end
  end
end
