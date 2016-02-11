class CheckoutService

  def initialize(current_user, order, stripe_token)
    @current_user = current_user
    @order = order
    @stripe_token = stripe_token
  end

  def place_order
    customer_id = retrieve_stripe_customer_id
    @current_user.update_attribute(:stripe_customer_id, customer_id)
    charge_customer(customer_id)
    finalize
    send_invoice
  end

  private

  def retrieve_stripe_customer_id
    if @stripe_token
      customer = Stripe::Customer.create(
        email:  @current_user.email,
        source: @stripe_token
      )
      return customer.id
    else
      return @current_user.stripe_customer_id
    end
  end

  def charge_customer(customer_id)
    Stripe::Charge.create(
      customer:     customer_id,
      amount:       @order.stripe_total,
      description:  'The Beautiful Rails Bookstore Purchase',
      currency:     'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def finalize
    @order.change_order_status_to("Payment Complete")
    @order.save
  end

  def send_invoice
    OrderMailer.invoice(@order).deliver_later
  end
end
