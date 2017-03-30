class PostsController < ApplicationController
before_action :authenticate_user!

  # Show only public, own, and collaborated wiki
  def index
    @posts = policy_scope(Post).paginate(page: params[:page], per_page: 15)
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def collaborate
    @post = Post.find(params[:id])
    authorize @post
  end

  def checkbox
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @post.private = params[:post][:private] || @post.private

    if @post.save # Calling database save/insert command
      flash[:success] = 'Post was saved.'
      redirect_to @post # Redirecting to @post will direct the user to the posts show view.
    else
      flash.now[:danger] = 'There was an error saving the post. Please try again.'
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
      flash[:success] = 'Post was saved.'
      redirect_to @post # Redirecting to @post will direct the user to the posts show view.
    else
      flash.now[:danger] = 'There was an error saving the post. Please try again.'
      render :new # render the new view again
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post

    if @post.destroy
      flash[:success] = "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash.now[:danger] = 'There was an error deleting the post.'
      render :show
    end
  end

end
