class CommentsController < ApplicationController
    layout 'boilerplate'
  
    def new
      @comment = Comment.new
    end
  
    def create
      @comment = Comment.new(comment_params)
      @comment.user = current_user
  
      if save_comment
        flash[:success] = 'Your Comment was added successfully!'
        redirect_to user_post_path(id: @comment.post_id, user_id: @comment.user_id)
      else
        flash.now[:error] = 'Error: Try Again, Comment could not be saved!'
        render_new_comment
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:text, :user_id, :post_id)
    end
  
    def save_comment
      @comment.save
    end
  
    def render_new_comment
      render :new, locals: { comment: @comment }
    end
  end
  