class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :book

  validates :cart, :book, presence: true
  delegate :title, to: :book

  def unit_price
    book.lowest_price
  end

  def total_price
    unit_price * quantity
  end
end
