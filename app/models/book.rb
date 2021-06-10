class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	belongs_to :category

     def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
     end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def self.search(search, word)
      if search
       Category.where(['title LIKE ?', "%#{search}%"]) #検索とcategoryの部分一致を表示。
      else
       all #全て表示させる
      end
    end
end
