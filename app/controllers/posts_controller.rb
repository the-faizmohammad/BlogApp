class PostsController < ApplicationController
  layout 'boilerplate'
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id]).order(id: :asc)
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
    @post.author_id = params[:user_id]
    if @post.save
      flash[:success] = 'Post added Successfully!'
      redirect_to user_posts_url
    else
      flash.now[:error] = 'Error: Post could not be saved!'
      render :new, locals: { post: @post }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
