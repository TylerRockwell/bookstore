class OrderDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  
  def total_in_dollars
    number_to_currency(total)
  end
end
