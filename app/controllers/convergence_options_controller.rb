class ConvergenceOptionsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show
    @convergence_option = current_default.convergence_option
  end
  
  def new
    @convergence_option = Convergence_Option.new
  end
  
  def edit
    @convergence_option = current_default.convergence_option
  end
  
  def update
    @convergence_option = current_default.convergence_option
    
    if @convergence_option.update(convergence_option_params)
      
      if (params[:analysis_id] == nil)
        save_path =  convergence_option_path(@convergence_option.id)
      else
        save_path = model_analysis_default_convergence_option_path(current_model.id, current_analysis.id, current_default.id, @convergence_option.id)
      end
      
      redirect_to save_path, :notice => "Convergence Options Updated Sucessfully"
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
    def convergence_option_params
      params.require(:convergence_option).permit(:mig, :tol1, :tol3, :tol5, :tol7, :alphac, :a3)
    end  
end
