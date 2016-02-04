require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:line_items) }

  describe "#calculate_total" do
    let(:cart)    { create(:cart) }
    let(:book_1)  { create(:book, price: 10) }
    let(:book_2)  { create(:book, price: 20) }
    let!(:item_1) { create(:line_item, cart: cart, book: book_1) }
    let!(:item_2) { create(:line_item, cart: cart, book: book_2) }
    it "calculates the total price for the order" do
      expect(cart.reload.calculate_total).to eq(item_1.total_price + item_2.total_price)
      expect(cart.reload.calculate_total).to eq(30)
    end
  end
end
