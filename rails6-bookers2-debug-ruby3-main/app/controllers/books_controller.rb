class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = current_user
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      flash.now[:error] = @book.errors.full_messages.join '/'
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      flash.now[:error] = @book.errors.full_messages.join '/'
      render "edit"
    end
  end

  def destroy  # deleteからdestroyに変更
    @book = Book.find(params[:id])
    @book.destroy  # スペルミスを修正
    redirect_to books_path, notice: "Book was successfully deleted."
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
