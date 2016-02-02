require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:order) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_presence_of(:order) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe "#set_unit_price_and_total" do
    let(:book) { create(:book) }
    let(:order_item) do
      OrderItem.new(book: book, order: create(:order), quantity: 5)
    end

    it "sets the unit price and total of an OrderItem" do
      expect(order_item.unit_price).to eq(nil)
      expect(order_item.total_price).to eq(nil)
      order_item.save
      expect(order_item.unit_price).to eq(book.price)
      expect(order_item.total_price).to eq(book.price * 5)
    end
  end
end
