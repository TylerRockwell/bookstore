When(/^I enter my payment details$/) do
  sleep(2) # wait for the js to create the popup in response to pressing the button
  within_frame 'stripe_checkout_app' do
    page.driver.browser.find_element(:id, 'email').send_keys('user@example.com')

    4.times { page.driver.browser.find_element(:id, 'card_number').send_keys('4242') }

    page.driver.browser.find_element(:id, 'cc-exp').send_keys '5'
    page.driver.browser.find_element(:id, 'cc-exp').send_keys '18'

    page.driver.browser.find_element(:id, 'cc-csc').send_keys '123'
    find('button[type="submit"]').click
    sleep(2)
  end
end

Then(/^I see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end
