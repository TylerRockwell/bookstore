Given(/^there are some books in the database$/) do
  @book = FactoryGirl.create(:book)
end

Given(/^I have a credit card saved on the site$/) do
  @user.update_attribute(:stripe_customer_id, "cus_7sT7NcC8IVAlU7")
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
  visit "/carts/#{@user.cart.id}"
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
  fill_in "Card Number", with: "4242424242424242"
  fill_in "CVC", with: 543
  fill_in "Month", with: 05
  fill_in "Year", with: (Time.now.year + 5)
end

When(/^I choose to use my saved credit card$/) do
  check "Use saved card"
end

Then(/^I am shown the order summary$/) do
  sleep(2)
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
  expect(page).to have_content@book.lowest_price
end

Then(/^my credit card is saved for future purchases$/) do
  expect(@user.reload.stripe_customer_id).to_not eq(nil)
end

Then(/^I am emailed an order invoice containing the books details, quantity, and order total$/) do
  expect(last_email.body.encoded).to include(@book.title)
  expect(last_email.body.encoded).to include(@book.lowest_price.to_s)
  expect(last_email.body.encoded).to include(@user.orders.last.total.to_s)
end
