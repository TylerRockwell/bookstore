class BookDecorator < ApplicationDecorator
  delegate_all
  include Draper::LazyHelpers

  def price_in_dollars
    number_to_currency(price)
  end

  def lowest_price_in_dollars
    number_to_currency(lowest_price)
  end

  def published_date_written
    published_date.strftime("%B %d, %Y")
  end

  def display_lowest_price
    if book.discounted_price
      "<div class='list-price'>#{price_in_dollars}</div>"\
      "<div class='sale-price'>#{lowest_price_in_dollars}</div>".html_safe
    else
      lowest_price_in_dollars
    end
  end
end
