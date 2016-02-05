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

  def purchase_button
    if line_items.count > 0
      button_to "Purchase", new_charge_path, method: :get, class: "btn btn-primary"
    end
  end
end
