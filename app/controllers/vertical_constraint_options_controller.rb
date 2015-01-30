class VerticalConstraintOptionsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def show
    @vertical_constraint_option = current_default.vertical_constraint_option
  end
  
  def new
    @vertical_constraint_option = Vertical_Constraint_Option.new
  end
  
  def edit
    @vertical_constraint_option = current_default.vertical_constraint_option
  end
  
  def update
    @vertical_constraint_option = current_default.vertical_constraint_option
    
    if @vertical_constraint_option.update(vertical_constraint_option_params)
      
      if (params[:analysis_id] == nil)
        save_path =  vertical_constraint_option_path(@vertical_constraint_option.id)
      else
        save_path = model_analysis_default_vertical_constraint_option_path(current_model.id, current_analysis.id, current_default.id, @vertical_constraint_option.id)
      end
      
      redirect_to save_path, :notice => "Vertical Constraint Updated Sucessfully"
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private
    def vertical_constraint_option_params
      params.require(:vertical_constraint_option).permit(:alphavcdef)
    end  
end
