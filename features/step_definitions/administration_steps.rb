Given(/^I have an admin account$/) do
  FactoryGirl.create(:admin, email: "admin@example.com", password: "password")
end

Given(/^I do not have an admin account$/) do
  Admin.delete_all
end

Given(/^I am logged into the admin panel$/) do
  FactoryGirl.create(:admin, email: "admin@example.com", password: "password")
  visit "/admin/sign_in"
  fill_in "Email", with: "admin@example.com"
  fill_in "Password", with: "password"
  click_button "Log in"
end

Given(/^I am logged into the site$/) do
  @user = FactoryGirl.create(:user, email: "user@example.com", password: "password")
  @user.confirm
  visit "/users/sign_in"
  fill_in "Email", with: "user@example.com"
  fill_in "Password", with: "password"
  click_button "Log in"
end

Given(/^there is a book named "([^"]*)"$/) do |book_title|
  FactoryGirl.create(:book, title: book_title)
end

Given(/^there is a book named "([^"]*)" valued at "([^"]*)"$/) do |book_title, price|
  @book = FactoryGirl.create(:book, title: book_title, price: price)
end

Given(/^There are orders$/) do
  @orders = FactoryGirl.create_list(:order, 20)
end

Given(/^the book has a discount of (\d+) dollars$/) do |amount|
  @book.apply_discount(discount_type: "dollars", discount_amount: amount)
end

When(/^I click "([^"]*)" for the book "([^"]*)"$/) do |link_text, book_title|
  find("div.row", text: book_title).click_link(link_text)
end

When(/^I visit the admin books url$/) do
  visit "/admin_api/books"
end

When(/^I click "([^"]*)"$/) do |text|
  click_on text
end

When(/^I enter the title "([^"]*)"$/) do |book_title|
  fill_in "Title", with: book_title
end

When(/^I enter the price "([^"]*)"$/) do |price|
  fill_in "Price", with: price
end

When(/^I enter the published date "([^"]*)"$/) do |published_date|
  fill_in 'Published date', with: published_date
end

When(/^I enter the author "([^"]*)"$/) do |author_name|
  fill_in "Author", with: author_name
end

When(/^I visit the public book index$/) do
  visit "/books"
end

When(/^I visit the admin panel url$/) do
  visit "/admin/sign_in"
end

When(/^I enter my admin email$/) do
  fill_in "Email", with: "admin@example.com"
end

When(/^I enter my admin password$/) do
  fill_in "Password", with: "password"
end

When(/^I confirm my decision to delete the book$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^I change the book name to "([^"]*)"$/) do |book_title|
  fill_in "Title", with: book_title
end

When(/^I change the book price to "([^"]*)"$/) do |book_price|
  fill_in "Price", with: book_price
end

Given(/^I enter the email "([^"]*)"$/) do |email|
  fill_in "Email", with: email
end

When(/^I visit the admin order index$/) do
  click_link "View a list of orders"
end

When(/^I apply a discount of (\d+) "([^"]*)"$/) do |amount, type|
  fill_in "Discount amount", with: amount
  choose "discount_type_#{type}"
end

When(/^I leave the discount fields blank$/) do
  fill_in "Discount amount", with: ""
end

Then(/^I see the book with a price of "([^"]*)" dollars$/) do |price|
  expect(page).to have_content(price)
end

Then(/^I see the admin panel$/) do
  expect(page).to have_content("Admin Dashboard")
end

Then(/^I see a flash notification that says "([^"]*)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I see the book "([^"]*)"$/) do |book_title|
  expect(page).to have_content(book_title)
end

Then(/^I see the book published date "([^"]*)"$/) do |published_date|
  expect(page).to have_content(published_date)
end

Then(/^I see the book author "([^"]*)"$/) do |author_name|
  expect(page).to have_content(author_name)
end

Then(/^I see a prompt requesting that I confirm my decision to delete the book$/) do
  page.driver.browser.switch_to.alert
end

Then(/^I don't see "([^"]*)"$/) do |book_name|
  expect(page).to_not have_content(book_name)
end

Then(/^I see a list of orders placed on the site$/) do
  expect(page).to have_content("Order Id")
  expect(page).to have_content("Placed By")
  expect(page).to have_content(@orders.first.id)
  expect(page).to have_content(@orders.first.user_email)
  expect(page).to have_content(@orders.first.number_of_order_items)
  expect(page).to have_content(@orders.first.total)
end
