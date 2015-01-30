class FoundationNodeOptionsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show
    @foundation_node_option = current_default.foundation_node_option
  end
  
  def new
    @foundation_node_option = Foundation_Node_Option.new
  end
  
  def edit
    @foundation_node_option = current_default.foundation_node_option
  end
  
  def update
    @foundation_node_option = current_default.foundation_node_option
    
    if @foundation_node_option.update(foundation_node_option_params)
      
      if (params[:analysis_id] == nil)
        save_path =  foundation_node_option_path(@foundation_node_option.id)
      else
        save_path = model_analysis_default_foundation_node_option_path(current_model.id, current_analysis.id, current_default.id, @foundation_node_option.id)
      end
      
      redirect_to save_path, :notice => "Foundation Node Options have been Updated Sucessfully"
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
    def foundation_node_option_params
      params.require(:foundation_node_option).permit(:ALP, :STRH, :STRVU, :STRVD)
    end 
end
