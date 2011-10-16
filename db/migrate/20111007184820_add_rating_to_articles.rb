class AddRatingToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :rating, :integer, :default => 0
  end

  def self.down
    remove_column :articles, :rating
  end
end
