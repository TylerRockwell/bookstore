class OrderItemDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def unit_price_in_dollars
    number_to_currency(unit_price)
  end

  def total_price_in_dollars
    number_to_currency(total_price)
  end
end
