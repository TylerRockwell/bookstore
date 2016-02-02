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
  expect(page).to have_content("Signed in successfully")
end

Given(/^there is a book named "([^"]*)"$/) do |book_title|
  FactoryGirl.create(:book, title: book_title )
end

Given(/^there is a book named "([^"]*)" valued at "([^"]*)"$/) do |book_title, price|
  FactoryGirl.create(:book, title: book_title, price: price )
end

When(/^I click "([^"]*)" for the book "([^"]*)"$/) do |link_text, book_title|
  find("div.row", text: book_title).click_link(link_text)
end

When(/^I visit the admin books url$/) do
  visit "/admin/books"
end

When(/^I click "([^"]*)"$/) do |button_text|
  click_button button_text
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

When(/^I click submit$/) do
  click_button "Log in"
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

Then(/^I see the admin panel$/) do
  expect(page).to have_content("Admin Dashboard")
end

Then(/^I see a flash notification that tell me that my email does not exist in the system$/) do
  expect(page).to have_content("Invalid email or password")
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
