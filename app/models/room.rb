class Room < ApplicationRecord
  has_many :category_rooms
  has_many :categories, through: :category_rooms
  belongs_to :user
  has_many :comments
  has_many :likes
  
  
  enum status: { open: 0, close: 2 }
  
  #def room_search
    #if params[:search].present?
      #@rooms = @rooms.joins(:user, :categories).where('rooms.title LIKE ? OR rooms.body LIKE ? OR users.name LIKE ? OR categories.name LIKE ?',
                                                      #"%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    #else
      #@rooms = @rooms.all
    #end
  #end
  
end
