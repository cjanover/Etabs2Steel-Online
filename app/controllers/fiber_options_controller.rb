class FiberOptionsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show
    @fiber_option = current_default.fiber_option
  end
  
  def new
    @fiber_option = Fiber_Option.new
  end
  
  def edit
    @fiber_option = current_default.fiber_option
  end
  
  def update
    @fiber_option = current_default.fiber_option
    if @fiber_option.update(fiber_option_params)
      
      if (params[:analysis_id] == nil)
        save_path =  fiber_option_path(@fiber_option.id)
      else
        save_path = model_analysis_default_fiber_option_path(current_model.id, current_analysis.id, current_default.id, @fiber_option.id)
      end
      
      redirect_to save_path, :notice => "Fiber Options have been Updated Sucessfully"
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
    def fiber_option_params
      params.require(:fiber_option).permit(:eec, :nsefbc, :nsefbr, :milf)
    end 
end
