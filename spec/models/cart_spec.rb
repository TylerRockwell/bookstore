require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:line_items) }

  describe "#total" do
    let(:cart) { create(:cart) }
    let(:item_1) { create(:line_item, cart: cart) }
    let(:item_2) { create(:line_item, cart: cart) }
    it "calculates the total price for the order" do
      cart.line_items << item_1
      cart.line_items << item_2
      expect(cart.total).to eq(item_1.total_price + item_2.total_price)
    end

    it "calculates the total price for the order" do
      item_1.book.price = 10
      item_2.book.price = 20
      cart.line_items << item_1
      cart.line_items << item_2
      expect(cart.total).to eq(30)
    end
  end
end
