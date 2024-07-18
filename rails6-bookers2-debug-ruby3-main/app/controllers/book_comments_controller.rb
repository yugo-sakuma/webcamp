class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.build(book_comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "コメントを投稿しました。"
    else
      flash[:alert] = "コメントの投稿に失敗しました。"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def correct_user
    @comment = BookComment.find(params[:id])
    unless @comment.user_id == current_user.id
      flash[:alert] = "自分のコメントのみ削除できます。"
      redirect_back(fallback_location: root_path)
    end
  end
end
