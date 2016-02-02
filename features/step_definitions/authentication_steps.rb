Given(/^I have an account on the site$/) do
  FactoryGirl.create(:user, email: "user@example.com", password: "password")
end

Given(/^My account is confirmed$/) do
  User.last.confirm
end

When(/^I enter my correct email$/) do
  fill_in "Email", with: "user@example.com"
end

When(/^I enter my password$/) do
  fill_in "Password", with: "password"
end

Then(/^I am redirected to the book index page$/) do
  expect(page).to have_content("Order books by:")
end

When(/^I enter the wrong password$/) do
  fill_in "Password", with: "LJWEOI"
end

Then(/^I am notified that my password is incorrect$/) do
  expect(page).to have_content("Invalid email or password")
end
