class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    current_user.favorites.create(book: @book)
    respond_to do |format|
      format.html { redirect_to sort_books_path }
      format.js
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    current_user.favorites.find_by(book: @book).destroy
    respond_to do |format|
      format.html { redirect_to sort_books_path }
      format.js
    end
  end
end
