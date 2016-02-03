class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  before_save :set_unit_price_and_total

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :book, :order, presence: true

  private

  def set_unit_price_and_total
    self.unit_price = book.price
    self.total_price = unit_price * quantity
  end
end
