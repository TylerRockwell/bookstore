class OrderMailer < ApplicationMailer
  def invoice(order)
    @order = order
    @order_items = @order.order_items
    mail(to: @order.user_email, subject: "Your recent order from Beautiful Rails Bookstore")
  end
end
