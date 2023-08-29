class UsersController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def index
    @user = current_user
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
