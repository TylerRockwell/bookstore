class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :addresses
  has_one  :cart

  after_create :build_cart

  private

  def build_cart
    cart || Cart.create(user: self)
  end
end
