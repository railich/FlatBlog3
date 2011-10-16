class ArticlesController < InheritedResources::Base
  respond_to :html
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  def index
    if params[:rating]
      @articles = Article.before_rating(3)
    else
      @articles = Article.above_rating(3)
    end
    # an array of IDs of articles for use in the helper and views
    @article_ids = cookies[:user_vote].present? ? Marshal.load(cookies[:user_vote]) : Array.new
  end

  def create
      create! { collection_url }
  end

  def update
      update! { collection_url }
  end

  # Rating (decrease / increase)
  def rating
    @article = Article.find(params[:id])

    # Add article ID in a cookie, if not vote for her
    article_ids = cookies[:user_vote].present? ? Marshal.load(cookies[:user_vote]) : Array.new
    unless article_ids.include?(@article.id)
      @article.change_rating(params[:value].to_i)
      article_ids.push(@article.id)
      cookies[:user_vote] = { :value => Marshal.dump(article_ids), :expires => 3.month.from_now, :domain => request.host }
    end

    if @article.save
      respond_to do |format|
        format.js
      end
    end
  end
end

