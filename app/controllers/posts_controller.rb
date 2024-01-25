class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.includes(:user).where(visibility: Post.visibilities[:公開]).order(created_at: :desc)
  end

  def show
  end

  def new
    @post = current_user.posts.new
    @private_posts = current_user.posts.where(visibility: Post.visibilities[:非公開]).order(created_at: :desc)
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_names = params[:post][:tag_names]
    if @post.save
      if tag_names.present?
        tags = tag_names.split(/[、,]+/).map(&:strip).uniq
        create_tags(@post, tags)
      end
      redirect_after_create
    else
      render :new
    end
  end

  def destroy
    if @post.destroy
      if @post.visibility == '公開'
        redirect_to posts_path, notice: '公開投稿が削除されました。'
      else
        redirect_to new_post_url, notice: '非公開投稿が削除されました。'
      end
    else
      redirect_to @post, alert: '投稿の削除に失敗しました。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :visibility).merge(visibility: params[:post][:visibility].to_i)
  end

  def redirect_after_create
    if @post.visibility == '公開'
      redirect_to posts_path, notice: '公開の投稿が作成されました。'
    else
      redirect_to @post, notice: '非公開の投稿が作成されました。'
    end
  end

  def create_tags(post, tags)
    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      post.tags << tag
    end
  end
end
