class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :book_title, presence: true

  def copy_data_from(line_item)
    self.book = line_item.book
    self.book_title = line_item.book.title
    self.quantity = line_item.quantity
    self.unit_price = line_item.book.lowest_price
    self.total_price = unit_price * quantity
  end
end
