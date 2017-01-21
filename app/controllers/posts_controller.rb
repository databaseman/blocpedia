class PostsController < ApplicationController
before_action :authenticate_user!
before_action :authorize_user_edit, only: [:edit]
before_action :authorize_user_delete, only: [:destroy]

# Show only public and own wiki
  def index
    @posts = Post.where( "private=0 OR user_id=?", params[current_user.id] )
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @post.private = params[:post][:private]

    if @post.save # Calling database save/insert command
      flash[:notice] = 'Post was saved.'
      redirect_to @post # Redirecting to @post will direct the user to the posts show view.
    else
      flash.now[:alert] = 'There was an error saving the post. Please try again.'
      render :new # render the new view again
    end
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @post.private = params[:post][:private]
    @post.user = current_user

    if @post.save # Calling database save/insert command
      flash[:notice] = 'Post was saved.'
      redirect_to @post # Redirecting to @post will direct the user to the posts show view.
    else
      flash.now[:alert] = 'There was an error saving the post. Please try again.'
      render :new # render the new view again
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash.now[:alert] = 'There was an error deleting the post.'
      render :show
    end
  end

  def authorize_user_edit
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin? || !post.private?
      flash[:alert] = 'You do not have permission.'
      redirect_to posts_path
    end
  end

  def authorize_user_delete
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin?
      flash[:alert] = 'You do not have permission.'
      redirect_to posts_path
    end
  end
end
