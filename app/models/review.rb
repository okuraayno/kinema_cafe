class Review < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence:true, length:{maximum:30}
  validates :comment, presence:true, length:{maximum:500}
  validates :tag, length:{maximum:30}

# レビュー検索
  def self.search_for(content, method)
    if method == 'perfect'
      Review.where(title: content)
    elsif method == 'forward'
      Review.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Review.where('title LIKE ?', '%' + content)
    else
      Review.where('title LIKE ?', '%' + content + '%')
    end
  end

# ソート機能
  scope :latest, -> {order(created_at: :desc)}
  scope :star_count, -> {order(star: :desc)}

end
