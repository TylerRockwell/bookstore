FactoryGirl.define do
  factory :line_item do
    book
    cart
    quantity 1
  end
end
