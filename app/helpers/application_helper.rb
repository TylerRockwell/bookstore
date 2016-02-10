module ApplicationHelper
  def current_user_cart
    current_user.cart.decorate
  end
end
