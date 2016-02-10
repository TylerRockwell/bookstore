Given(/^there are (\d+) books in the database$/) do |number_of_books|
  @books = FactoryGirl.create_list(:book, number_of_books.to_i)
end

When(/^I visit the root url$/) do
  visit '/'
end

Given(/^some books have been ordered$/) do
  FactoryGirl.create_list(:order_item, 5, book: @books.first)
end

When(/^I sort by "([^"]*)"$/) do |field|
  select(field, from: "Order books by:")
  click_on "Submit"
end

Then(/^the books are re\-sorted based on the amount of times they are purchased$/) do
  expect(first('//div.store-book-list div.row')).to have_content(@books.first.title)
end

Then(/^I see a list of books in the database$/) do
  expect(page).to have_content(Book.by_published.first.title)
end

Then(/^the books are ordered by published date$/) do
  expect(page).to have_content(Book.by_published.first.published_date)
  expect(page).to_not have_content(Book.by_published.last.published_date)
end

Then(/^the list of books is paginated (\d+) books per page$/) do |books_per_page|
  expect(page).to have_css("div.store-book-list div.row", count: books_per_page)
end

When(/^I enter a book's title into the book search field$/) do
  fill_in "Search", with: @books.first.title
  click_on "Submit"
end

Then(/^I am shown a list of books with that title$/) do
  expect(page).to have_content(@books.first.title)
  expect(page).to_not have_content(@books.last.title)
end
