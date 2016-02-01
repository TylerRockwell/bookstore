class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
