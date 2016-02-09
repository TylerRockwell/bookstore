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
    # I know this controller action is fat. It will be refactored in a future PR
    order = current_user.orders.pending.last
    if order
      # Amount in cents
      amount = order.stripe_total

      if session[:stripeToken]
        customer = Stripe::Customer.create(
          email:  current_user.email,
          source: session[:stripeToken]
        )
        session[:stripeToken] = nil
        customer_id = customer.id
      else
        customer_id = current_user.stripe_token
      end

      current_user.save_stripe_token(customer_id)

      Stripe::Charge.create(
        customer:     customer_id,
        amount:       amount,
        description:  'The Beautiful Rails Bookstore Purchase',
        currency:     'usd'
      )

      order.change_order_status_to("Payment Complete")
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
