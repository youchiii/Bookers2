class UsersController < ApplicationController
before_action :move_to_signed_in  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book)
      flash[:notice] = "Welcome! You have signed up successfully."
    else
      @books = Book.all
      render :index
    end
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def index
    @user = current_user
    @users = User.all
  end

private

  def move_to_signed_in
    unless user_signed_in?
      redirect_to '/users/sign_in'
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
