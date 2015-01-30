class ResponseTimeHistoryOptionsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show
    @response_time_history_option = current_default.response_time_history_option
  end
  
  def new
    @response_time_history_option = Response_Time_History_Options.new
  end
  
  def edit
    @response_time_history_option = current_default.response_time_history_option
  end
  
  def update
    @response_time_history_option = current_default.response_time_history_option
    
    if @response_time_history_option.update(response_time_history_option_params)
      
      if (params[:analysis_id] == nil)
        save_path =  response_time_history_option_path(@response_time_history_option.id)
      else
        save_path = model_analysis_default_response_time_history_option_path(current_model.id, current_analysis.id, current_default.id, @response_time_history_option.id)
      end
      
      redirect_to save_path, :notice => "Response Time History Options have been Updated Sucessfully"
    else
      rendit :edit
    end
  end
  
  def destroy
  end
  
  private
    def response_time_history_option_params
      params.require(:response_time_history_option).permit(:plotall, :plotsecondary)
    end 
end

