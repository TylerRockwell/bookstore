require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:order) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:book_title) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe "#copy_data_from" do
    let(:line_item) { create(:line_item, quantity: 5) }
    let(:order_item) { create(:order_item) }

    it "sets the unit price and total of an OrderItem" do
      order_item.copy_data_from(line_item)
      order_item.save
      expect(order_item.book).to eq(line_item.book)
      expect(order_item.book_title).to eq(line_item.book.title)
      expect(order_item.quantity).to eq(BigDecimal.new(line_item.quantity, 12))
      expect(order_item.unit_price).to eq(BigDecimal.new(line_item.unit_price, 12))
      expect(order_item.total_price).to eq(BigDecimal.new((line_item.unit_price * 5), 12))
    end
  end
end
