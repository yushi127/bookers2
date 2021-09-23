class UsersController < ApplicationController
  before_action :set_user
  before_action :move_to_signed_in

  def move_to_signed_in
    unless user_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to  '/users/sign_in'
    end
  end
  
  def index
    @users = User.all
    @book=Book.new

    # @books = @user.books.reverse_order
    # byebug
  end
  def show
    @finduser = User.find(params[:id])
    @books = @finduser.books.reverse_order
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
    finduser = User.find(params[:id])
    unless @user == finduser
      redirect_to  user_path(@user)
    end
  end

  def update
    @finduser = User.find(params[:id])
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
  def set_user
    @user = current_user
  end
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
