class Book < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
