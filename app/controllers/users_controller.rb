class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "You do not have correct right!"
      redirect_to("/posts/index")
    end
  end
  def index
    @users = User.all
  end
  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new()
  end
  def create
    @user = User.new(name: params[:name], email: params[:email], image_name: "default.png", password: params[:password])
    if @user.save
      flash[:notice] = "Successful user registration!"
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      redirect_to("/users/#{@user.id}")
    else
      render("/users/new.html.erb")
    end
  end
  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = "Successful user information editing!"
      redirect_to("/users/#{@user.id}")
    else
      render("/users/edit.html.erb")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email],
                         password: params[:password])
    if @user
      flash[:notice] = "Successful login! Hello #{@user.name}!"
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      redirect_to("/posts/index")
    else
      @error_message = "E-mail address or password is wrong"
      @email = params[:email]
      @password = params[:password]
      render("/users/login_form.html.erb")
    end
  end
  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    flash[:notice] = "Logged out!"
    redirect_to("/login")
  end
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end
end





