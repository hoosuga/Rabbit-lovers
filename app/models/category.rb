class Category < ApplicationRecord
  has_many :category_rooms
  has_many :rooms, through: :category_rooms
  
  validates :name, presence: true
end
