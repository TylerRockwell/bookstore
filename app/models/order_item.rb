class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  before_save :set_unit_price_and_total

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :book, :order, presence: true

  delegate :title, to: :book

  def unit_price
    if persisted?
      self[:unit_price]
    else
      book.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private

  def set_unit_price_and_total
    self[:unit_price] = unit_price
    self[:total_price] = total_price
  end
end
