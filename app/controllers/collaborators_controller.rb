class CollaboratorsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
    @users=User.where.not( id: current_user.id)
    @post=Post.find(params[:id])    
  end

  def update
  end

  def delete
  end
end
