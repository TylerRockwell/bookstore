module ApplicationHelper
  def cart
    current_user.cart.decorate
  end
end
