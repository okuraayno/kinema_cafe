class Review < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy


  validates :title, presence:true
  validates :comment, presence:true, length:{maximum:500}
  validate :unique_tags

  validates :tag1, presence: true
  validates :tag2, presence: true, if: -> { tag2.present? }
  validates :tag3, presence: true, if: -> { tag3.present? }
  def unique_tags
# tag1, tag2, tag3の中で重複したタグがあるかチェックする
    if [tag1, tag2, tag3].uniq.length != [tag1, tag2, tag3].length
      errors.add(:base, "同じ内容のタグを入力することはできません")
    end
  end


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
