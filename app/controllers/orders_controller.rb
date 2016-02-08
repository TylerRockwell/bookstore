class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.build_shipping_address
    @order.build_billing_address
  end

  def create
    @order = Order.new(order_params)
    @order.add_items_from(cart)
    @order.user = current_user
    if @order.save
      cart.empty
      session[:checkout_order_id] = @order.id
      redirect_to new_charge_path
    end
  end

  def show
    @order = Order.includes(:order_items).find_by(id: params[:id])
    @order_items = @order.order_items
  end

  private

  def order_params
    params.require(:order).permit(
      shipping_address_attributes: [:street_number, :street_name, :city, :state, :zip],
      billing_address_attributes: [:street_number, :street_name, :city, :state, :zip]
    )
  end
end
