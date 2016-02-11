class CheckoutService
  def initialize(current_user, order, stripe_token)
    @current_user = current_user
    @order = order
    @stripe_token = stripe_token
  end

  def place_order
    customer_id = retrieve_stripe_customer_id
    @current_user.update_attribute(:stripe_customer_id, customer_id)
    if charge_customer(customer_id)
      @current_user.cart.empty
      finalize
      send_invoice
      return true
    else
      return false
    end

  rescue Stripe::CardError
    return false

  rescue Stripe::InvalidRequestError
    return false
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

  rescue Stripe::CardError
    return false

  rescue Stripe::InvalidRequestError
    return false
  end

  def finalize
    @order.change_order_status_to("Payment Complete")
    @order.save
  end

  def send_invoice
    OrderMailer.invoice(@order).deliver_later
  end
end
