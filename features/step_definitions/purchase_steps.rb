Given(/^there are some books in the database$/) do
  @book = FactoryGirl.create(:book)
end

When(/^I click on a book$/) do
  expect(page).to have_content(@book.title)
  find("div.row", text: @book.title).click_link(@book.title)
end

When(/^I adjust the quantity of the book to (\d+)$/) do |number|
  fill_in "line_item_quantity", with: number
  click_button("Update")
end

When(/^I enter (\d+) for the quantity$/) do |number|
  fill_in "Quantity", with: number
end

When(/^I visit my cart$/) do
  visit "/carts/1"
end

Then(/^I am asked for my shipping address$/) do
  expect(page).to have_content("Shipping Address")
end

When(/^I enter a valid shipping address$/) do
  within(:xpath, '//div[@class="shipping-address"]') do
    fill_in "Street number", with: 123
    fill_in "Street name", with: "Fake Street"
    fill_in "City", with: "New York"
    fill_in "State", with: "NY"
    fill_in "Zip", with: "10108"
  end
end

Then(/^I am asked for my billing address$/) do
  expect(page).to have_content("Billing Address")
end

When(/^I enter a valid billing address$/) do
  within(:xpath, '//div[@class="billing-address"]') do
    fill_in "Street number", with: 123
    fill_in "Street name", with: "Fake Street"
    fill_in "City", with: "New York"
    fill_in "State", with: "NY"
    fill_in "Zip", with: "10108"
  end
end

When(/^I enter a valid credit card$/) do
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

Then(/^I am shown the order summary$/) do
  expect(page).to have_content("Your order from Beautiful Rails Bookstore")
end

Then(/^the book is added to my cart$/) do
  @cart = @user.cart
  expect(@cart.line_items).to_not eq(nil)
  last_line_item = @cart.line_items.last
  expect(last_line_item.book).to eq(@book)
end

Then(/^I see the book in my cart$/) do
  expect(page).to have_content(@book.title)
end

Then(/^the book is added to my cart with quantity (\d+)$/) do |number|
  @cart = @user.cart
  last_line_item = @cart.line_items.last

  expect(@cart.line_items).to_not eq(nil)
  expect(last_line_item.book).to eq(@book)
  expect(last_line_item.quantity).to eq(number.to_i)
end

Then(/^I see the book in my cart with quantity (\d+)$/) do |number|
  expect(page).to have_content(@book.title)
  find(:css, "#line_item_quantity") == number
end

Then(/^I am asked to review the order total$/) do
  expect(page).to have_content@book.price
end
