Given(/^there are some books in the database$/) do
  @book = FactoryGirl.create(:book)
end

When(/^I click on a book$/) do
  expect(page).to have_content(@book.title)
  find("div.row", text: @book.title).click_link(@book.title)
end

When(/^I adjust the quantity of the book to (\d+)$/) do |number|
  fill_in "order_item_quantity", with: number
  click_button("Update")
end

When(/^I enter (\d+) for the quantity$/) do |number|
  fill_in "Quantity", with: number
end

When(/^I visit my cart$/) do
  visit "/carts/1"
end

Then(/^the book is added to my cart$/) do
  @cart = @user.cart
  expect(@cart.order_items).to_not eq(nil)
  last_order_item = @cart.order_items.last
  expect(last_order_item.book).to eq(@book)
end

Then(/^I see the book in my cart$/) do
  expect(page).to have_content(@book.title)
end

Then(/^the book is added to my cart with quantity (\d+)$/) do |number|
  @cart = @user.cart
  last_order_item = @cart.order_items.last

  expect(@cart.order_items).to_not eq(nil)
  expect(last_order_item.book).to eq(@book)
  expect(last_order_item.quantity).to eq(number.to_i)
end

Then(/^I see the book in my cart with quantity (\d+)$/) do |number|
  expect(page).to have_content(@book.title)
  find(:css, "#order_item_quantity").value == number
end
