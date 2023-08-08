class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
         
  has_many :rooms
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_rooms, through: :likes, source: :room
  
  validates :name, presence: true, length: { maximum: 30 }

  def self.search(params)
    User.where('(users.name LIKE ? OR users.introduction LIKE ?) AND users.is_deleted = ?', 
                  "%#{params[:search]}%", "%#{params[:search]}%", params[:status].to_i == 1 ? true : false)
  end
  
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [80, 80]).processed
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲスト') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
 
end
