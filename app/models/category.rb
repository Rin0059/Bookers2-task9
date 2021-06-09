class Category < ApplicationRecord
  has_many :category
  belongs_to :book
end
