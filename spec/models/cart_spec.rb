require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:line_items) }
  end

  let(:cart) { create(:cart) }
  describe "#total" do
    context "when there are no items in the cart" do
      it "returns 0" do
        expect(cart.total).to eq(0)
      end
    end
    context "when there are items in the cart" do
      let(:book_1)  { create(:book, price: 10) }
      let(:book_2)  { create(:book, price: 20) }
      let!(:item_1) { create(:line_item, cart: cart, book: book_1) }
      let!(:item_2) { create(:line_item, cart: cart, book: book_2) }
      it "returns the total price of items in the cart" do
        expect(cart.total).to eq(item_1.total_price + item_2.total_price)
        expect(cart.total).to eq(30)
      end
    end
  end

  describe "#stripe_total" do
    context "when there are no items in the cart" do
      it "returns 0" do
        expect(cart.total).to eq(0)
      end
    end
    context "when there are items in the cart" do
      let(:book_1)  { create(:book, price: 10) }
      let(:book_2)  { create(:book, price: 20) }
      let!(:item_1) { create(:line_item, cart: cart, book: book_1) }
      let!(:item_2) { create(:line_item, cart: cart, book: book_2) }
      it "returns the total price of items in the cart in cents" do
        expect(cart.stripe_total).to eq(3000)
      end
    end
  end
end
