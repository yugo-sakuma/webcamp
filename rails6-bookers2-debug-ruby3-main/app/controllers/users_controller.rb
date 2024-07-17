class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find_by(id: params[:id])
    if @user
      @books = @user.books
      @book = Book.new
    else
      redirect_to root_path, alert: "User not found."
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      p 'success'
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      flash.now[:error] = @user.errors.full_messages
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :title)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
