class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = cart.stripe_total

    customer = Stripe::Customer.create(
      email:  params[:stripeEmail],
      source: params[:stripeToken]
    )

    Stripe::Charge.create(
      customer:     customer.id,
      amount:       @amount,
      description:  'The Beautiful Rails Bookstore Purchase',
      currency:     'usd'
    )

    redirect_to books_path, notice: "Your order has been placed. You should receive "\
      "an email confirmation shortly."

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
