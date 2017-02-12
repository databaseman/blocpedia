class CollaboratorsController < ApplicationController
before_action :authenticate_user!
before_action :authorize_user_edit, only: [:edit, :show, :destroy ]
before_action :authorize_user_delete, only: [:destroy]

  def index
  end

  def show
    @users=User.where.not( id: current_user.id)
    @post=Post.find(params[:id])
  end

  def new
  end

  def create
    @collaborator = Collaborator.new
    @collaborator.user_id=params[:user_id]
    @collaborator.post_id=params[:post_id]
    if @collaborator.save # Calling database save/insert command
      flash[:notice] = 'User was added.'
      redirect_to action: "show", id: @collaborator.post_id
    else
      flash.now[:alert] = 'There was an error adding the user. Please try again.'
      redirect_to action: "show", id: @collaborator.post_id # render the new view again
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @user=User.find( @collaborator.user_id )
    debugger
    
    if @collaborator.destroy
      flash[:notice] = "\"#{@user.email}\" was removed successfully."
      redirect_to action: "show", id: @collaborator.post_id
    else
      flash.now[:alert] = 'There was an error removing the user.'
      redirect_to action: "show", id: @collaborator.post_id
    end
  end

  def authorize_user_edit
    post = Post.find(params[:id])
    unless helpers.user_authorized_for_edit_post?(post)
      flash[:alert] = 'You do not have permission.'
      redirect_to posts_path
    end
  end

  def authorize_user_delete
    post = Post.find(params[:post_id])
    unless helpers.user_authorized_for_delete_post?(post)
      flash[:alert] = 'You do not have permission.'
      redirect_to posts_path
    end
  end
end
