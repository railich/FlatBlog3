module ArticlesHelper

  # a rating of articles to display in ajax
  def get_rating(article_id)
    Article.find(article_id).rating
  end

  # output adjusting key if the identifier is not contained in the article cookies
  def raiting_block(article_id, article_rating)
    unless @article_ids.include?(article_id)
      content_tag :span, :id => 'article_' + article_id.to_s do
        link_to( '-', url_for(action: 'rating', id: article_id.to_s, value: '-1'), :remote => true) +
        h(article_rating) +
        link_to( '+', url_for(action: 'rating', id: article_id.to_s, value: '1'), :remote => true)
      end
    else
      content_tag :span, :id => 'article_' + article_id.to_s do
        h(article_rating)
      end
    end
  end

  #order by rating
  def order_by_rating
    if params[:controller] == 'articles' and params[:action] == 'index' #should appear only in articles controller
      if params[:rating]
        link_to "sort by date, rating above than 3", articles_path
      else
        link_to "sort by date, rating less than 3", articles_path(:rating => 'true')
      end
  elsif params[:controller] =~ /devise/
      link_to "Go Back", :back
    else
      link_to "Back to Articles list", articles_path
    end
  end

  #comment link for article list
  def comments_link(article)
    link_to pluralize(article.comments.size == 0 ? "No" : article.comments.size.to_s, "Comment"), article_comments_path(article)
  end
end

