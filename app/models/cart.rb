class Cart < ActiveRecord::Base
  belongs_to  :user
  has_many    :line_items
  before_save :update_total

  def calculate_total
    line_items.inject(0) { |sum, item| sum + item.total_price }
  end

  private

  def update_total
    self.total = calculate_total
  end
end
