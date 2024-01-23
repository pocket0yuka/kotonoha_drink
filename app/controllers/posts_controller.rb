class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @public_posts = Post.where(visibility: Post.visibilities[:公開])
  end

  def show
  end

  def new
    @post = current_user.posts.new
    @private_posts = current_user.posts.where(visibility: Post.visibilities[:非公開])
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: '投稿が作成されました。'
    else
      render :new
    end
  end
end

private

def set_post
  @post = Post.find(params[:id])
end

def post_params
  params.require(:post).permit(:body, :visibility).merge(visibility: params[:post][:visibility].to_i)
end
