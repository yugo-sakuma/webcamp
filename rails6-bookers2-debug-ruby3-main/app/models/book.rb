class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :with_recent_favorites_count, -> {
    left_joins(:favorites)
      .where('favorites.created_at > ?', 1.week.ago)
      .group('books.id')
      .select('books.*, COUNT(favorites.id) AS favorites_count')
      .order('favorites_count DESC, books.created_at DESC')
  }
end
