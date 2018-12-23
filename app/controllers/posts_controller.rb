class PostsController < ApplicationController
  # ユーザを認識
  before_action :authenticate_user
  # ユーザ情報が正しいかどうか先に確認してから編集, 削除機能だけ開放
  # ユーザは自分の投稿しか編集, 削除できない
  before_action :ensure_correct_user ,{only: [:edit, :update, :destroy]}

  # その投稿が, ログインユーザのものであるかどうか確認
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "You do not have correct right!"
      redirect_to("/posts/index")
    end
  end

  # 投稿一覧
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  # 投稿1件の詳細
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end

  # 更新ボタン押した時
  def new
    @post = Post.new()
  end

  # 新規投稿
  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "Successful message creating!"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  # 編集する投稿を取ってくる
  def edit
    @post = Post.find_by(id: params[:id])
  end

  # 編集した投稿をDBに登録
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "Successful message editing!"
      redirect_to("/posts/index")
    else
      render("/posts/edit.html.erb")
    end
  end

  # 投稿削除
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "Successful message deleting!"
    redirect_to("/posts/index")
  end
end

