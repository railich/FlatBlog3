class CommentsController < InheritedResources::Base
  actions :index, :create
  belongs_to :article

  def create
    create! { collection_url }
  end
end

