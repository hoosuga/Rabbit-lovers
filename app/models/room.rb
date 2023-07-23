class Room < ApplicationRecord
  has_many :category_rooms
  has_many :categories, through: :category_rooms
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  
  enum status: { open: 0, close: 2 }
  
  def self.search(params)
     Room.joins(:user, :categories).where('rooms.title LIKE ? OR rooms.body LIKE ? OR users.name LIKE ? OR categories.name LIKE ?',
                                          "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").distinct
  end
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
end
