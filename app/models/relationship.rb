class Relationship < ApplicationRecord
  
# フォローされているユーザーのidを取得する外部キー
  belongs_to :follower, class_name: "User"
# フォローしたユーザーのidを取得する外部キー
  belongs_to :followed, class_name: "User"

end
