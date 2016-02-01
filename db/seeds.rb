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

Admin.create!(
  email:    "admin@example.com",
  password: "password"
)
