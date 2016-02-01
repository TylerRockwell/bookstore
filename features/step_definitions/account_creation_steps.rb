Given(/^I do not have an account on the site$/) do
  User.find_by_email('my_email@example.com') == nil
end

When(/^I visit the site root path$/) do
  visit '/'
end

Then(/^I am presented with a login page$/) do
  expect(page).to have_content("Log in")
end

When(/^I click the "([^"]*)" link$/) do |link_title|
  click_link link_title
end

When(/^I enter my email address$/) do
  fill_in 'Email', with: 'my_email@example.com'
end

When(/^I enter a password with correct confirmation$/) do
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
end

When(/^I click the "([^"]*)" button$/) do |button_name|
  click_button button_name
end

Then(/^I am told to check my email for a confirmation link$/) do
  expect(page).to have_content('confirmation link has been sent to your email')
end

Then(/^I am sent a confirmation email$/) do
  last_email != nil
end

When(/^I visit the link in that email$/) do
  confirmation_token = last_email.body.match(/confirmation_token=\w*/)
  visit "/users/confirmation?#{confirmation_token}"
end

Then(/^My email address becomes confirmed$/) do
  User.last.confirmed_at != nil
end
