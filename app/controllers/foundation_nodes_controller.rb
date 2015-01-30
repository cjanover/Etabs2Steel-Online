class FoundationNodesController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def index
    @foundation_nodes = current_default.foundation_node_option.foundation_nodes
  end
  
  def show
    @foundation_node = current_default.foundation_node_option.foundation_nodes.find(params[:id])
  end
  
  def new
    @foundation_node = current_default.foundation_node_option.foundation_nodes.new
  end
  
  def edit
    @foundation_node = current_default.foundation_node_option.foundation_nodes.find(params[:id])
  end
  
  def update
    @foundation_node = current_default.foundation_node_option.foundation_nodes.find(params[:id])
    if @foundation_node.update(foundation_node_params)
      if params[:analysis_id] == nil
        save_path = foundation_node_option_path(current_default.foundation_node_option.id)
      else
        save_path = model_analysis_default_foundation_node_option_path(current_model.id, current_analysis.id, current_default.id, current_default.foundation_node_option.id)
      end
            
      redirect_to save_path
    else
      render :edit
    end
  end
  
  def create
    @foundation_node = current_default.foundation_node_option.foundation_nodes.new(foundation_node_params)
    if @foundation_node.save
      if params[:analysis_id] == nil
        save_path = foundation_node_option_path(current_default.foundation_node_option.id)
      else
        save_path = model_analysis_default_foundation_node_option_path(current_model.id, current_analysis.id, current_default.id, current_default.foundation_node_option.id)
      end
            
      redirect_to save_path
    else
      render :new
    end
  end
  
  def destroy
    current_default.foundation_node_option.foundation_nodes.find(params[:id]).destroy
    redirect_to foundation_node_option_path(current_default.foundation_node_option.id)
  end
  
  private
    def foundation_node_params
      params.require(:foundation_node).permit(:name, :ALP, :STRH, :STRVU, :STRVD)
    end  
end
