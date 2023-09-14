class Room < ApplicationRecord
  has_many :category_rooms
  has_many :categories, through: :category_rooms
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 400 }
  validates :status, presence: true
  validate :exist_category_room
  
  
  enum status: { open: 0, close: 2 }, _prefix: true
  
  def self.search(params)
     Room.joins(:user, :categories).where('rooms.title LIKE ? OR rooms.body LIKE ? OR users.name LIKE ? OR categories.name LIKE ?',
                                          "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").distinct
  end
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
  def exist_category_room
    errors[:base] << "カテゴリ名にチェックを1つ以上入れてください" if self.category_rooms.size.zero?
  end
  
end
