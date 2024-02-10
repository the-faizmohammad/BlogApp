class Api::PostsController < ApplicationController
    def index
      @user = User.find(params[:user_id])
      @posts = @user.posts
      render json: @posts
    end

    def show
      @post = Post.find(params[:post_id])
      render json: @post
    end

    def create_comment
      @post = Post.find(params[:post_id])
      @comment = @post.comments.create(comment_params)
      render json: @comment, status: :created
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end
