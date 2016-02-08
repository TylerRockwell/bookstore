class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :order, inverse_of: :shipping_address

  validates :street_number, :street_name, :city, presence: true
  validates :state, :zip, :order, presence: true
end