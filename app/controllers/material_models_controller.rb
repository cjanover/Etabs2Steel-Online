class MaterialModelsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show
    @material_model = current_default.material_model
  end
  
  def new
    @material_model = Material_Model.new
  end
  
  def edit
    @material_model = current_default.material_model
  end
  
  def update
    @material_model = current_default.material_model
    
    if @material_model.update(material_model_params)
      
      if (params[:analysis_id] == nil)
        save_path =  material_model_path(@material_model.id)
      else
        save_path = model_analysis_default_material_model_path(current_model.id, current_analysis.id, current_default.id, @material_model.id)
      end
      
      redirect_to save_path, :notice => "Material Models Updated Sucessfully"
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
    def material_model_params
      params.require(:material_model).permit(:steelmat_G, :steelmat_Sy, :defwallshearmod, :mat_1_E, :mat_1_ES, :mat_1_SIGY, :mat_1_SIGU, :mat_1_EPSS, :mat_1_EPSU, :mat_1_PRAT, :mat_1_RES, :mat_2_E, :mat_2_ES, :mat_2_SIGY, :mat_2_SIGU, :mat_2_EPSS, :mat_2_EPSU, :mat_2_PRAT, :mat_2_RES, :concretemat_E, :concretemat_CS, :concretemat_PCT, :materialconv1, :materialconv2, :materialconv3)
    end  
end
