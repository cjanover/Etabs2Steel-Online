class AnalysisOptionsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show
    @analysis_option = current_default.analysis_option
  end
  
  def new
    @analysis_option = Analysis_Option.new
  end
  
  def edit
    @analysis_option = current_default.analysis_option
  end
  
  def update
    @analysis_option = current_default.analysis_option
    
    if @analysis_option.update(analysis_option_params)
      if params[:analysis_id] == nil
        save_path = analysis_option_path(@analysis_option.id)
      else
        save_path = model_analysis_default_analysis_option_path(current_model.id, current_analysis.id, current_default.id, @analysis_option.id)
      end
      
      redirect_to save_path, :notice => "Analysis Options Updated Sucessfully"
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
    def analysis_option_params
      params.require(:analysis_option).permit(:panel_zone_rigidity, :mtp, :ndim, :nss, :beta, :gamma, :a0, :first_mode_period, :damping_ratio_stiffness, :damping_ratio_column, :base_shear_percent, :base_shear, :r, :base_drift, :dt, :irint, :irout, :istop, :debuglevel, :sectionconversion, :matconversion)
    end  
end
