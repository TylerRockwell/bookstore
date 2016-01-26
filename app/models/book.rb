class Book < ActiveRecord::Base
  validates :title,           presence: true
  validates :published_date,  presence: true
  validates :author,          presence: true
  validates :price,           presence: true
end
