class Review < ApplicationRecord

  belongs_to :user
  
  validates :review_title, presence:true
  validates :review_comment, presence:true, length:{maximum:500}

end
