Book.delete_all
250.times do
  Book.create!(
    title: Faker::Book.title,
    published_date: Faker::Date.between(100.years.ago, Date.today),
    author: Faker::Book.author,
    price: Faker::Number.decimal(2),
    description: Faker::Hipster.paragraph(5),
    category: Faker::Book.genre
  )
end

Admin.delete_all
Admin.create!(
  email:    "admin@example.com",
  password: "password"
)
User.delete_all
User.create!(
  email:    "user@example.com",
  password: "password"
).confirm
