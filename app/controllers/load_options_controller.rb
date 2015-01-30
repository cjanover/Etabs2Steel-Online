class LoadOptionsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show
    @load_option = current_default.load_option
  end
  
  def new
    @load_option = Load_Option.new
  end
  
  def edit
    @load_option = current_default.load_option
  end
  
  def update
    @load_option = current_default.load_option
    
    puts "here here"
    puts params
    
    if @load_option.update(load_option_params)
      
      if (params[:analysis_id] == nil)
        save_path =  load_option_path(@load_option.id)
      else
        save_path = model_analysis_default_load_option_path(current_model.id, current_analysis.id, current_default.id, @load_option.id)
      end
      
      redirect_to save_path, :notice => "Load Options Updated Sucessfully"
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
    def load_option_params
      params.require(:load_option).permit(:load_combo, :mass_combo, :gamult)
    end 
end
