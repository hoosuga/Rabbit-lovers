class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  def self.search(params)
    comments =  Comment.where('comments.body LIKE ?', "%#{params[:search]}%")
    return comments
  end
  
end
