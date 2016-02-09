class ChargesController < ApplicationController
  def new
    order = current_user.orders.pending.last
    if order
      @amount = order.total
    else
      redirect_to books_path, alert: "You must buy something to check out"
    end
  end

  def create
    order = current_user.orders.pending.last
    if order
      # Amount in cents
      amount = order.stripe_total
      customer = Stripe::Customer.create(
        email:  current_user.email,
        source: params[:stripeToken]
      )

      Stripe::Charge.create(
        customer:     customer.id,
        amount:       amount,
        description:  'The Beautiful Rails Bookstore Purchase',
        currency:     'usd'
      )

      order.mark_as("paid")
      order.save
      redirect_to order_path(order), notice: "Your order has been placed. You should receive "\
        "an email confirmation shortly."
    else
      redirect_to root_path, alert: "How did you even get here?"
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
