class ModelInformationsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show    
    @model_information = current_default.model_information
  end
  
  def new
    @model_information = ModelInformation.new
  end
  
  def edit
    @model_information = current_default.model_information
  end
  
  def update
    @model_information = current_default.model_information

    if @model_information.update(model_information_params)

      if (params[:analysis_id] == nil)
        save_path =  model_information_path(@model_information.id)
      else
        save_path = model_analysis_default_model_information_path(current_model.id, current_analysis.id, current_default.id, @model_information.id)
      end
      
      redirect_to save_path, :notice => "Model Information Options Updated Sucessfully"
    else
      render :edit
    end
  end
  
  private
    def model_information_params
      params.require(:model_information).permit(:title, :primaryetabsdir, :steelsection, :analysis_id)
    end  
end
