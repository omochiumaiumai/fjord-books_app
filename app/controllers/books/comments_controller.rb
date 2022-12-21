class Books::CommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = book.comments.new(comment_params)
    comment.user = current_user
    comment.save!
    redirect_to book
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
