require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:book) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_presence_of(:cart) }
  end

  describe "#unit_price" do
    let(:book) { create(:book, price: 5) }
    let(:line_item) { create(:line_item, book: book) }
    it "returns the price of the line_item's book" do
      expect(line_item.unit_price).to eq(5)
    end
  end

  describe "#total_price" do
    let(:book) { create(:book, price: 5) }
    let(:line_item) { create(:line_item, book: book, quantity: 4) }
    it "returns the total price of itself (unit_price * quantity)" do
      expect(line_item.total_price).to eq(20)
    end
  end
end
