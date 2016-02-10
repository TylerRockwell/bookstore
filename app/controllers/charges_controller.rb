class ChargesController < ApplicationController
  def new
    order = last_pending_order
    if order
      @amount = order.total
    else
      redirect_to books_path, alert: "You must buy something to check out"
    end
  end

  def create
    order = last_pending_order
    if order
      customer_id = retrieve_stripe_customer_id
      current_user.update_attribute(:stripe_customer_id, customer_id)
      charge_customer(customer_id, order.stripe_total)
      order.finalize
      redirect_to order_path(order), notice: "Your order has been placed. You should receive "\
        "an email confirmation shortly."
    else
      redirect_to root_path, alert: "How did you even get here?"
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def last_pending_order
    current_user.orders.pending.last
  end

  def retrieve_stripe_customer_id
    if session[:stripeToken]
      customer = Stripe::Customer.create(
        email:  current_user.email,
        source: session[:stripeToken]
      )
      session[:stripeToken] = nil
      return customer.id
    else
      return current_user.stripe_customer_id
    end
  end

  def charge_customer(customer_id, amount)
    Stripe::Charge.create(
      customer:     customer_id,
      amount:       amount,
      description:  'The Beautiful Rails Bookstore Purchase',
      currency:     'usd'
    )
  end
end
