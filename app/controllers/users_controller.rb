class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    @book=Book.new

    # @books = @user.books.reverse_order
    # byebug
  end
  def show
    @user = User.find(params[:id])
    @books = @user.books.reverse_order
    # byebug
    @book=Book.new

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = @user.id
    if @book.save
      flash[:notice] = "Book was successfully updated.."
      redirect_to book_path(id: @book)
    else
      render :index
    end
  end
  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    # byebug
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "User was successfully updated.."
    else
      flash[:alert] = "User was not updated."
      # redirect_to book_path(book)
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
