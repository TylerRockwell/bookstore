class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :book, presence: true

  before_create :set_prices

  delegate :title, to: :book

  private

  def set_prices
    self.unit_price = book.price
    self.total_price = unit_price * quantity
  end
end
