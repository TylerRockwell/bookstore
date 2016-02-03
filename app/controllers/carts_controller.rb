class CartsController < ApplicationController
  def show
    @cart = cart
    @order_items = cart.order_items
  end
end
