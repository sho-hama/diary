class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new()
  end

  def create
    @post = Post.new(content: params[:content])
    if @post.save
      flash[:notice] = "Successful message creating!"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end
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
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "Successful message deleting!"
    redirect_to("/posts/index")
  end
end

