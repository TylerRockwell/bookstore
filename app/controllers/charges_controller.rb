class ChargesController < ApplicationController
  def new
    order = last_pending_order
    if order
      @order = order.decorate
    else
      redirect_to books_path, alert: "You must buy something to check out"
    end
  end

  def create
    order = last_pending_order
    if order
      if go_to_checkout.place_order
        redirect_to order_path(order), notice: "Your order has been placed. You should receive "\
          "an email confirmation shortly."
      else
        redirect_to new_charge_path, alert: "There was a problem with the payment. "\
          "Your card has not been charged."
      end
    else
      redirect_to root_path, alert: "How did you even get here?"
    end
  end

  private

  def last_pending_order
    current_user.orders.pending.last
  end

  def go_to_checkout
    CheckoutService.new(current_user, last_pending_order, session[:stripe_token])
  end
end
