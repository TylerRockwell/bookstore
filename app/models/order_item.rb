class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order
  belongs_to :cart

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :book, presence: true

  delegate :title, to: :book

  def unit_price
    book.price
  end

  def total_price
    unit_price * quantity
  end
end
