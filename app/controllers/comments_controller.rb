class CommentsController < ApplicationController
  load_and_authorize_resource
  layout 'boilerplate'
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Comment added successfully!'
      redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
    else
      flash.now[:error] = 'Error: Comment could not be saved!'
      render :new, locals: { comment: @comment }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.decrement!(:comments_counter)
    @comment.destroy!
    flash[:success] = 'Comment deleted.'
    redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end