class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price

  delegate :sortable_fields, to: :class

  def self.order_by(field, list_order)
    list_order ||= "ASC"
    field ||= "published_date"
    Book.order("#{field} #{list_order}")
  end

  def self.sortable_fields
    [:title, :published_date, :author, :price, :category]
  end
end
