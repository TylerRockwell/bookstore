class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  has_many :addresses
  has_one  :cart

  after_create :create_cart

  def save_stripe_token(token)
    self.stripe_token = token
    save
  end
end
