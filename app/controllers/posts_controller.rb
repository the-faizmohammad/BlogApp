class PostsController < ApplicationController
  load_and_authorize_resource
  layout 'boilerplate'
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).order(id: :asc)
    @posts = @posts.paginate(page: params[:page], per_page: 2)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      flash[:success] = 'Post added Successfully!'
      redirect_to user_posts_url
    else
      flash.now[:error] = 'Error: Post could not be saved!'
      render :new, locals: { post: @post }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.author.decrement!(:posts_counter)
    @post.comments.destroy_all
    @post.likes.destroy_all
    @post.destroy!
    flash[:success] = 'Post Deleted!'
    redirect_to user_posts_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end