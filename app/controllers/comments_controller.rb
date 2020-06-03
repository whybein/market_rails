class CommentsController < ApplicationController
  def create
    @comment = Comment.create comment_params
    # redirect_to item_path(comment.item)
  end

  def update
    comment = Comment.find_by(id: params[:id])
    comment.update(commnet_params) if comment
    redirect_to item_path(comment.item)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    # byebug
    @comment.destroy if @comment
    # redirect_to item_path(comment.item)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :item_id)
  end
end
