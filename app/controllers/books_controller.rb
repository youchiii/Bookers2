class BooksController < ApplicationController
before_action :move_to_signed_in  
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
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
    @comments = BookComment.all
    flash[:notice] = "You have created book successfully."
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @comment = BookComment.new
    @comments = BookComment.all
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  private
  
  def move_to_signed_in
    unless user_signed_in?
      redirect_to '/users/sign_in'
    end
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
