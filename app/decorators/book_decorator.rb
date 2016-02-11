class BookDecorator < ApplicationDecorator
  delegate_all
  include Draper::LazyHelpers

  def price_in_dollars
    number_to_currency(price)
  end

  def published_date_written
    published_date.strftime("%B %d, %Y")
  end

  def published_date_mm_dd_yyyy
    published_date.strftime("%m %d %Y")
  end
end
