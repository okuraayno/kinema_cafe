class Review < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy

  
  validates :title, presence:true
  validates :comment, presence:true, length:{maximum:500}
  
end
