Given(/^I have an admin account$/) do
  FactoryGirl.create(:admin, email: "admin@example.com", password: "password")
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

Then(/^I see the admin panel$/) do
  expect(page).to have_content("Admin Dashboard")
end
