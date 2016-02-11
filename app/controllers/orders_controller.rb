class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.build_shipping_address
    @order.build_billing_address
    @stripe_publishable_key = Rails.configuration.stripe[:publishable_key]
  end

  def create
    @order = Order.new(order_params)
    @order.add_items_from(cart)
    @order.user = current_user
    if @order.save
      @order.change_order_status_to("Pending")
      session[:stripe_token] = params[:stripeToken]
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
