class Order < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :user
  has_many   :order_items
  has_one    :billing_address,  class_name: Address, inverse_of: :order
  has_one    :shipping_address, class_name: Address, inverse_of: :order

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address

  before_create :set_order_status

  delegate :name, to: :order_status, prefix: true

  scope :pending, -> { where(order_status_id: 1) }

  def total
    order_items.inject(0) { |sum, item| sum + item.total_price }
  end

  def add_items_from(cart)
    cart.line_items.each do |cart_item|
      OrderItem.create(
        order:      self,
        book:       cart_item.book,
        quantity:   cart_item.quantity
      )
    end
  end

  def stripe_total
    (total * 100).to_i
  end

  private

  def set_order_status
    self.order_status_id = 1 # 'Pending'
  end
end
