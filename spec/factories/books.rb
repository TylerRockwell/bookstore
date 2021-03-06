FactoryGirl.define do
  factory :book do
    title           { Faker::Book.title }
    published_date  { Faker::Date.between(100.years.ago, Date.today) }
    author          { Faker::Book.author }
    price           { Faker::Number.decimal(2) }
    category        { Faker::Book.genre }
  end
end
