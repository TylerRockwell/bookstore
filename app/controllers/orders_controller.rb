class OrdersController < ApplicationController
  def create
    @order = Order.new
    @order.add_items_from(cart)
    if @order.save
      cart.empty
      redirect_to new_charge_path
    end
  end
end
