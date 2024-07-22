class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :with_recent_favorites_count, -> {
    left_joins(:favorites)
         .group('books.id')
         .order('COUNT(favorites.id) DESC, books.created_at DESC')
  }
end
