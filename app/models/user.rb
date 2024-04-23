class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true,length: { maximum: 50 }
  validates :email, presence: true,uniqueness: true
  validates :password, presence: true

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

# ゲストログイン用
  GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end

# フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
# フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
# フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed
# フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower
# 指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
# 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
# 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end

#ユーザーステータスが有効or利用停止である場合のユーザーログインについて
  def user_status
    if is_active == false
      "利用停止"
    else
      "有効"
    end
  end
  
  def active_for_authentication?
    super && (is_active == true)
  end

# ユーザー検索
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

# 画像の取得
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_square.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
