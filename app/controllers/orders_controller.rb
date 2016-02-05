class OrdersController < ApplicationController
  def create
    @order = Order.new
    @order.add_items_from(cart)
    if @order.save
      cart.empty
      session[:checkout_order_id] = @order.id
      redirect_to new_charge_path
    end
  end
end
