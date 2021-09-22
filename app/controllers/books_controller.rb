class BooksController < ApplicationController


  def index
    @books=Book.all
    @book=Book.new
    @user = current_user
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
    @user = current_user
    @book = Book.find(params[:id])
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
  
  def book_params
     params.require(:book).permit(:title,:body)
  end

end
