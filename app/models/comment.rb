class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :review

  validates :comment, presence: true, length:{maximum:100}

end
