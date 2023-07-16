class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  def self.search(params)
    Comment.where('comments.body LIKE ?', "%#{params[:search]}%")
  end
  
end
