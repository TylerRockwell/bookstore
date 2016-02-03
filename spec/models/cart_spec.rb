require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:order_items) }

  describe "#calculate_total" do
    let(:cart) { create(:cart) }
    let(:item_1) { create(:order_item, cart: cart) }
    let(:item_2) { create(:order_item, cart: cart) }
    it "calculates the total price for the order" do
      cart.order_items << item_1
      cart.order_items << item_2
      expect(cart.calculate_total).to eq(item_1.total_price + item_2.total_price)
    end

    it "calculates the total price for the order" do
      item_1.book.price = 10
      item_2.book.price = 20
      cart.order_items << item_1
      cart.order_items << item_2
      expect(cart.calculate_total).to eq(30)
    end
  end
end
