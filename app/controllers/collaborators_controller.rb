class CollaboratorsController < ApplicationController
before_action :authenticate_user!

  def index
  end

  def show
    @post=Post.find(params[:id])
    authorize @post
    @users=User.where.not( id: current_user.id, role: 'admin' ).paginate(page: params[:page], per_page: 10)
  end

  def new
  end

  def create
    @collaborator = Collaborator.new
    @collaborator.user_id=params[:user_id]
    @collaborator.post_id=params[:post_id]
    if @collaborator.save # Calling database save/insert command
      flash[:success] = 'User was added.'
      redirect_to action: "show", id: @collaborator.post_id
    else
      flash.now[:danger] = 'There was an error adding the user. Please try again.'
      redirect_to action: "show", id: @collaborator.post_id # render the new view again
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @post=Post.find(params[:post_id])
    authorize @post
    @collaborator = Collaborator.find(params[:id])
    @user=User.find( @collaborator.user_id )

    if @collaborator.destroy
      flash[:success] = "\"#{@user.email}\" was removed successfully."
      redirect_to action: "show", id: @collaborator.post_id
    else
      flash.now[:danger] = 'There was an error removing the user.'
      redirect_to action: "show", id: @collaborator.post_id
    end
  end


end
