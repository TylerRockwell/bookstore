class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price
  has_many :order_items

  scope :by_published, -> { order(published_date: :desc) }
  scope :most_popular, -> { all.includes(:order_items).sort_by(&:times_sold).reverse! }

  def self.order_by(field, list_order)
    if field
      order(field => list_order)
    else
      by_published
    end
  end

  def self.sort_options
    options = Book.searchable_fields.map { |field| [field.to_s.humanize, field.to_s] }
    options << ["Most popular"]
    options
  end

  def self.searchable_fields
    [:title, :author, :category]
  end

  def self.search(query)
    search_clauses = searchable_fields.map { |field| "#{field} LIKE :q" }
    where(search_clauses.join(' OR '), q: "%#{query}%")
  end

  def times_sold
    order_items.sum(:quantity)
  end

  def published_date_written
    published_date.strftime("%B %d, %Y")
  end

  def apply_discount(args)
    if args[:discount_type] == "dollars"
      self.discounted_price = price - args[:discount_amount].to_f
    elsif args[:discount_type] == "percent"
      self.discounted_price = price * (1 - args[:discount_amount].to_f)
    end
  end

  def remove_discount
    self.discounted_price = nil
  end

  def lowest_price
    discounted_price || price
  end
end
