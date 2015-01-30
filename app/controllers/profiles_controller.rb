class ProfilesController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show
    @profile = User.find(current_user.id).profile
  end
  
  def new
    @profile = Profile.new
  end
  
  def edit
    @profile = User.find(current_user.id).profile
  end
  
  def update
    @profile = User.find(current_user.id).profile
    puts "here here"
    puts profile_params
    if @profile.update(profile_params)
      redirect_to profile_path(@profile.id), :notice => "Profile Overview Updated Sucessfully"
    else
    
    end
  end
  
  def destroy
    current_user.profile.destroy
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :company)
    end
end
