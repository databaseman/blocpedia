class PostsController < ApplicationController
before_action :authenticate_user!
#before_action :authorize_user_edit, only: [:edit, :show, :destroy ]
#before_action :authorize_user_delete, only: [:destroy]

  # Show only public, own, and collaborated wiki
  def index
    @posts = policy_scope(Post).paginate(page: params[:page], per_page: 20)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if helpers.user_authorized_for_private_checkbox?(@post)
      @post.private = params[:post][:private]
    end

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
    authorize @post
    
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash.now[:alert] = 'There was an error deleting the post.'
      render :show
    end
  end

end
