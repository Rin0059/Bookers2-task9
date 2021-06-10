class Category < ApplicationRecord
  has_many :category, dependent: :destroy
  has_many :books
end
