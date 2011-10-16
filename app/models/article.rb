class Article < ActiveRecord::Base
  has_many :comments, :dependent => :destroy

  validates :title, :content, :category, :presence => true

  @default_rating = 3
  scope :above_rating, lambda { |rating| where('rating > ?',  rating).order('DATE(created_at) DESC, rating DESC').includes(:comments) }
  scope :before_rating, lambda { |rating| where('rating <= ?', rating).order('DATE(created_at) DESC, rating DESC').includes(:comments) }

  CATEGORY = ['sport', 'humor', 'news', 'tech']

  def change_rating(rating)
    self.rating += rating
    self.save
  end
end

