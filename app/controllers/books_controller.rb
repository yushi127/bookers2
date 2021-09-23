class BooksController < ApplicationController
  before_action :set_user
  before_action :move_to_signed_in, except: [:welcome,:about]

  def move_to_signed_in
    unless user_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to  '/users/sign_in'
    end
  end
  def index
    @books=Book.all
    @book=Book.new
  end

  def create
    @books=Book.all
    @book = Book.new(book_params)
    @book.user_id = @user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(id: @book)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id === @user.id
      redirect_to  books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = "Book was successfully updated.."
    else
      flash[:alert] = "Book was not updated error."
      # redirect_to book_path(book)
      render :edit
    end
  end

  def show
    @book = Book.find(params[:id])
    @finduser = @book.user
    @booknew=Book.new
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path
      flash[:notice] = "Book was successfully destroyed."
    else
      flash[:alert] = "Book was not destroyed error."
    end
  end
  def welcome
  end
  def about
  end

  private
  def set_user
    @user = current_user
  end
  def book_params
     params.require(:book).permit(:title,:body)
  end

end
