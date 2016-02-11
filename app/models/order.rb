class Order < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :user
  has_many   :order_items

  has_one    :billing_address,  class_name: Address, inverse_of: :order
  has_one    :shipping_address, class_name: Address, inverse_of: :order

  accepts_nested_attributes_for :billing_address, reject_if: :all_blank
  accepts_nested_attributes_for :shipping_address

  delegate :name, to: :order_status, prefix: true
  delegate :email, to: :user, prefix: true
  delegate :formatted_nicely, to: :shipping_address, prefix: true

  scope :pending, -> { where(order_status_id: OrderStatus.find_by(name: "Pending")) }

  def total
    order_items.inject(0) { |sum, item| sum + item.total_price }
  end

  def add_items_from(cart)
    cart.line_items.each do |line_item|
      build_order_item(line_item)
    end
  end

  def build_order_item(line_item)
    order_item = order_items.build
    order_item.copy_data_from(line_item)
  end

  def stripe_total
    (total * 100).to_i
  end

  def change_order_status_to(status)
    self.order_status = OrderStatus.find_by(name: status)
    save
  end

  def number_of_order_items
    order_items.count
  end
end
