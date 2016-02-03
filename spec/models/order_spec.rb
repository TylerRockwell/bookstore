require 'rails_helper'
RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:order_status) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:order_items) }

  describe "#calculate_total" do
    let!(:order) { create(:order) }
    let!(:item_1) { create(:order_item, order: order) }
    let!(:item_2) { create(:order_item, order: order) }
    it "calculates the total price for the order" do
      order.order_items << item_1
      order.order_items << item_2
      expect(order.calculate_total).to eq(item_1.total_price + item_2.total_price)
    end
  end
end
