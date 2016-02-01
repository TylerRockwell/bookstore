class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price
  has_many :order_items
  
  scope :by_published, -> { order(published_date: :desc) }

  def self.order_by(field, list_order)
    if field
      order(field => list_order)
    else
      by_published
    end
  end

  def self.sortable_fields
    [:title, :published_date, :author, :price, :category]
  end

  def self.search(query)
    search_clauses = sortable_fields.map { |field| "#{field} LIKE :q" }
    where(search_clauses.join(' OR '), q: "%#{query}%")
  end
end
