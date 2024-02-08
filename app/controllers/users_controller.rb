class UsersController < ApplicationController
  layout 'boilerplate'

  def index
    @users = User.includes(:posts).order(id: :asc)
  end

  def show
    @user = User.find(params[:id])
  end
end
