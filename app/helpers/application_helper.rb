module ApplicationHelper
  def cart
    current_user.cart.decorate if current_user.cart
  end
end
