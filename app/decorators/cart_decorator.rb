class CartDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def header_display
    link_to "#{pluralize(cart.number_items_in_cart, 'item')}  in cart. "\
      "Total: #{number_to_currency(cart.total)}", cart_path(cart)
  end

  def formatted_total
    number_to_currency(total)
  end

  def checkout_button
    button_to "Checkout", new_charge_path, method: :get, class: "btn btn-primary" if total > 0
  end
end
