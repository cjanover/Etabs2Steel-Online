class VerticalConstraintsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def index
    @vertical_constraints = current_default.vertical_constraint
  end
  
  def show
    @vertical_constraint = current_default.vertical_constraint
  end
  
  def new
    @model_name = "vertical_constraint"
    @vertical_constraint = current_default.vertical_constraint_option.vertical_constraint.new
  end
  
  def edit
    @model_name = "vertical_constraint"
    @vertical_constraint = current_default.vertical_constraint.find(params[:id])
  end
  
  def update
    @vertical_constraint = current_default.vertical_constraint.find(params[:id])
    
    if (params[:analysis_id] != nil)
      route = model_analysis_default_vertical_constraint_option_path(current_model.id, current_analysis.id, current_default.id, current_default.vertical_constraint_option.id)
      
      @vertical_constraint.node_id = params[:vertical_constraint][:node_id]
      
      @vertical_constraint.x = current_model.nodes.find_by_id(params[:vertical_constraint][:node_id]).X
      @vertical_constraint.y = current_model.nodes.find_by_id(params[:vertical_constraint][:node_id]).Y
      @vertical_constraint.z = current_model.nodes.find_by_id(params[:vertical_constraint][:node_id]).Z
      
      @vertical_constraint.alphavc = params[:vertical_constraint][:alphavc]
      
    else
      route = vertical_constraint_option_path(current_default.vertical_constraint_option.id)
    end
    
    if @vertical_constraint.save
      redirect_to route
    else
      render :edit
    end
  end
  
  def create
    @vertical_constraint = current_default.vertical_constraint_option.vertical_constraint.new(vertical_constraint_params)
 
    if (params[:analysis_id] != nil)
      route = model_analysis_default_vertical_constraint_option_path(current_model.id, current_analysis.id, current_default.id, current_default.vertical_constraint_option.id)
      
      @vertical_constraint.node_id = params[:vertical_constraint][:node_id]
      
      @vertical_constraint.x = current_model.nodes.find_by_id(params[:vertical_constraint][:node_id]).X
      @vertical_constraint.y = current_model.nodes.find_by_id(params[:vertical_constraint][:node_id]).Y
      @vertical_constraint.z = current_model.nodes.find_by_id(params[:vertical_constraint][:node_id]).Z
      
      @vertical_constraint.alphavc = params[:vertical_constraint][:alphavc]
      
    else
      route = vertical_constraint_option_path(current_default.vertical_constraint_option.id)
    end
    
    if @vertical_constraint.save
      redirect_to route
    else
      render :new
    end
  end
  
  def destroy
    current_default.vertical_constraint.find(params[:id]).destroy
    
    if (params[:analysis_id] != nil)
      route = model_analysis_default_vertical_constraint_option_path(current_model.id, current_analysis.id, current_default.id, current_default.vertical_constraint_option.id)
    else
      route = vertical_constraint_option_path(current_default.vertical_constraint_option.id)
    end
    
    redirect_to route
  end
  
  private
    def vertical_constraint_params
      if params[:analysis_id] != nil
        params.permit(:vertical_constraint, :node_id)
      else
        params.require(:vertical_constraint).permit(:x, :y, :z, :alphavc)        
      end
    end  
end
