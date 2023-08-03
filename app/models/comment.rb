class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :body, presence: true, length: { maximum: 400 }
  
  def self.search(params)
    Comment.where('comments.body LIKE ?', "%#{params[:search]}%")
  end
  
end
