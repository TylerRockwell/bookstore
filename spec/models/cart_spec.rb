require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:line_items) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:user) }
  end

  let(:empty_cart) { create(:cart) }
  let(:cart_with_items) do
    cart = create(:cart)
    book1 = create(:book, price: 10)
    book2 = create(:book, price: 20)
    create(:line_item, cart: cart, book: book1)
    create(:line_item, cart: cart, book: book2)
    cart
  end

  describe "#total" do
    context "when there are no items in the cart" do
      it "returns 0" do
        expect(empty_cart.total).to eq(0)
      end
    end
    context "when there are items in the cart" do
      it "returns the total price of items in the cart" do
        expect(cart_with_items.total).to eq(30)
      end
    end
  end

  describe "#stripe_total" do
    context "when there are no items in the cart" do
      it "returns 0" do
        expect(empty_cart.total).to eq(0)
      end
    end
    context "when there are items in the cart" do
      it "returns the total price of items in the cart in cents" do
        expect(cart_with_items.stripe_total).to eq(3000)
      end
    end
  end

  describe "#number_items_in_cart" do
    context "when there are no items in the cart" do
      it "returns 0" do
        expect(empty_cart.number_items_in_cart).to eq(0)
      end
    end

    context "when there are items in the cart" do
      it "returns the total price of items in the cart" do
        expect(cart_with_items.number_items_in_cart).to eq(2)
      end
    end
  end

  describe "#empty" do
    context "when there are no items in the cart" do
      it "runs but does not change anything" do
        empty_cart.empty
        expect(empty_cart.line_items).to eq([])
      end
    end
    context "when there are items in the cart" do
      it "removes all items from the cart" do
        expect(cart_with_items.line_items).to_not eq([])
        cart_with_items.empty
        expect(cart_with_items.line_items).to eq([])
      end
    end
  end
end
