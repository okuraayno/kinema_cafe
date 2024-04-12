class Review < ApplicationRecord

  belongs_to :user
  
  validates :title, presence:true
  validates :comment, presence:true, length:{maximum:500}

end
