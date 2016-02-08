class OrderItem < ActiveRecord::Base
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :book_title, presence: true

  def set_item_data(line_item)
    self.book_title = line_item.book.title
    self.quantity = line_item.quantity
    self.unit_price = line_item.book.price
    self.total_price = unit_price * quantity
  end
end
