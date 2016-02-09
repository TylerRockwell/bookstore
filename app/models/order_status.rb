class OrderStatus < ActiveRecord::Base
  has_many :orders

  validates :name, uniqueness: true
  validates :display, uniqueness: true
end
