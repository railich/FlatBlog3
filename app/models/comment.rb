class Comment < ActiveRecord::Base
  belongs_to :article

  validates :author, :content, :presence => true
end

