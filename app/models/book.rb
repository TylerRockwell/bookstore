class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price

  def self.order_by(field, list_order)
    list_order ||= "ASC"
    field ||= "published_date"
    field.gsub!(/\s/, '_')
    field.downcase!
    Book.order("#{field} #{list_order}")
  end

  def self.sortable_fields
    ["Title", "Published Date", "Author", "Price", "Category"]
  end
end
