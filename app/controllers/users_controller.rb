class UsersController < ApplicationController
  before_action :authenticate, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
     
    if @user.save
      #Create new profile
      @user.create_profile(:last_name => "", :first_name => "", :company => "")      
      
      
      redirect_to root_path, notice: 'User successfully created.'
    else
      render action: :new
    end
  end
  
  def load
    current_user.profile.active_name = params[:id]
    
    if current_user.profile.save
      redirect_to user_path(current_user.id)
    else
      redirect_to user_path(current_user.id)
    end
  end
    
  def edit
  end
  
  def show
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path
  end
    
  def update
    if @user.update(user_params)
      redirect_to root_path, notice:'Updated user information successfully'
    else
      render action: 'edit'
    end
  end
    
  private
    def set_user
      @user = User.find(params[:id])
    end
      
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end

  
