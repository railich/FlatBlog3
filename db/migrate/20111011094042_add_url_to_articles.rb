class AddUrlToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :url, :string
    add_column :articles, :tags, :string
  end

  def self.down
    remove_column :articles, :tags
    remove_column :articles, :url
  end
end
