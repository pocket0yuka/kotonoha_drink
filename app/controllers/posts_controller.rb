# frozen_string_literal: true

# 投稿のコントローラ
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  # 公開時の投稿を表示
  def index
    @post = current_user.posts.new
    @q = Post.ransack(params[:q])
    # タグとユーザーを事前に読み込み（N+1防止）
    @posts = @q.result.includes(:tags, :user).where(visibility: Post.visibilities[:公開]).order(created_at: :desc)
  end

  def private
    @post = current_user.posts.new
    @q = Post.ransack(params[:q])
    # タグとユーザーを事前に読み込み（N+1防止）
    @private_posts = @q.result.includes(:tags, :user).where(visibility: Post.visibilities[:非公開]).order(created_at: :desc)
  end

  def show
  end

  # 新規投稿ページの表示
  def new
    @q = current_user.posts.ransack(params[:q])
    # 非公開投稿を取得
    @private_posts = @q.result.where(visibility: Post.visibilities[:非公開]).order(created_at: :desc)
    @post = current_user.posts.new
    @post.tag_names = params[:tag_names] if params[:tag_names].present?
    @post.body = params[:body] if params[:body].present?
    @post.drink_word = params[:drink_word] if params[:drink_word].present?
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    # モデルにないのでtagを直接取得
    tag_names = params[:post][:tag_names]

    if @post.body.blank?
      flash[:alert] = '本文を入力してください。'
      redirect_to new_post_path
      return # 以降の処理は実行しない
    end

    if @post.save
      # タグがあれば追加
      add_tags(tag_names) if tag_names.present?

      if @post.visibility == '非公開'
        redirect_to  private_posts_path
      else
        # 公開投稿の場合のリダイレクト
        redirect_to posts_path
      end
    else
      render :new
    end
  end

  def update
  end

  def destroy
    if @post.destroy
      if @post.visibility == '公開'
        redirect_to posts_path
      else
        redirect_to  private_posts_path
      end
    else
      redirect_to @post
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  # タグの作成と投稿への追加
  def create_tags(post, tags)
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      post.tags << tag unless post.tags.include?(tag)
    end
  end

  def post_params
    params.require(:post).permit(:body, :image, :image_cache, :drink_word, :visibility).merge(visibility: params[:post][:visibility].to_i)
  end

  # タグが指定されている場合にタグを追加
  def add_tags(tag_names)
    tags = tag_names.split(/[、,]+/).map(&:strip).uniq
    create_tags(@post, tags)
  end

  def blank
    return if @post.body.blank?
  end
end
