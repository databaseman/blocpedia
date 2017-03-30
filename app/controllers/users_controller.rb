class UsersController < ApplicationController
  def index
    @users=User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user=User.find(params[:id])
  end

  def destroy
    @user=User.find(params[:id])
    if @user.destroy
      flash[:success] = "\"#{@user.email}\" was deleted successfully."
      redirect_to root_path
    else
      flash.now[:danger] = 'There was an error deleting the user. Please try again.'
      redirect_to users_index_path
    end
  end

end
