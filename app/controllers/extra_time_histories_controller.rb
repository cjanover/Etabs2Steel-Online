class ExtraTimeHistoriesController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  respond_to :html, :js
  
  #Methods
  def index
    @extra_time_histories = current_default.response_time_history_option.extra_time_histories
  end
  
  def show
    @extra_time_history = current_default.response_time_history_option.extra_time_histories.find_by_id(params[:id])
  end
  
  def new
    @model_name = "extra_time_history"
    @extra_time_history = current_default.response_time_history_option.extra_time_histories.new
  end
  
  def edit
    @model_name = "extra_time_history"
    @extra_time_history = current_default.response_time_history_option.extra_time_histories.find(params[:id])
  end
  
  def update
    @extra_time_history = current_default.response_time_history_option.extra_time_histories.find(params[:id])
    
    if (params[:analysis_id] != nil) #Then its from Analysis      
      route = model_analysis_default_response_time_history_option_path(current_model.id, current_analysis.id, current_default.id, current_default.response_time_history_option.id)
        
      @extra_time_history.node_id = params[:extra_time_history][:node_id]
        
      @extra_time_history.x1 = current_model.nodes.find_by_id(params[:extra_time_history][:node_id]).X
      @extra_time_history.y1 = current_model.nodes.find_by_id(params[:extra_time_history][:node_id]).Y
      @extra_time_history.z1 = current_model.nodes.find_by_id(params[:extra_time_history][:node_id]).Z
      
      @extra_time_history.outputvalue = params[:extra_time_history][:outputvalue]
      @extra_time_history.outputtype = params[:extra_time_history][:outputtype]
      
      if (params[:extra_time_history][:node2_id] != nil)
        @extra_time_history.node2_id = params[:extra_time_history][:node2_id]
        @extra_time_history.x2 = current_model.nodes.find_by_id(params[:extra_time_history][:node2_id]).X
        @extra_time_history.y2 = current_model.nodes.find_by_id(params[:extra_time_history][:node2_id]).Y
        @extra_time_history.z2 = current_model.nodes.find_by_id(params[:extra_time_history][:node2_id]).Z
      end    
    else
      route = response_time_history_option_path(current_default.response_time_history_option.id)
    end

    #puts extra_time_history_params
     
    if @extra_time_history.save
      redirect_to route
    else
      render :edit
    end
  end
  
  def create
    @extra_time_history = current_default.response_time_history_option.extra_time_histories.new(extra_time_history_params)
    
    if (params[:analysis_id] != nil) #Then its from Analysis      
      route = model_analysis_default_response_time_history_option_path(current_model.id, current_analysis.id, current_default.id, current_default.response_time_history_option.id)
        
      @extra_time_history.node_id = params[:extra_time_history][:node_id]
        
      @extra_time_history.x1 = current_model.nodes.find_by_id(params[:extra_time_history][:node_id]).X
      @extra_time_history.y1 = current_model.nodes.find_by_id(params[:extra_time_history][:node_id]).Y
      @extra_time_history.z1 = current_model.nodes.find_by_id(params[:extra_time_history][:node_id]).Z
      
      @extra_time_history.outputvalue = params[:extra_time_history][:outputvalue]
      @extra_time_history.outputtype = params[:extra_time_history][:outputtype]
      
      if (params[:extra_time_history][:node2_id] != nil)
        @extra_time_history.node2_id = params[:extra_time_history][:node2_id]
        @extra_time_history.x2 = current_model.nodes.find_by_id(params[:extra_time_history][:node2_id]).X
        @extra_time_history.y2 = current_model.nodes.find_by_id(params[:extra_time_history][:node2_id]).Y
        @extra_time_history.z2 = current_model.nodes.find_by_id(params[:extra_time_history][:node2_id]).Z
      end    
    else
      route = response_time_history_option_path(current_default.response_time_history_option.id)
    end

    #puts extra_time_history_params
     
    if @extra_time_history.save
      redirect_to route
    else
      render :new
    end
  end
  
  def destroy
    @extra_time_history = current_default.response_time_history_option.extra_time_histories.find(params[:id]).destroy
    
    if (params[:analysis_id] != nil)
      route = model_analysis_default_response_time_history_option_path(current_model.id, current_analysis.id, current_default.id, current_default.response_time_history_option.id)
    else
      route = response_time_history_option_path(current_default.response_time_history_option.id)
    end
    
    redirect_to route
  end
  
  private
    def extra_time_history_params
      if params[:analysis_id] != nil
        params.permit(:extra_time_history, :node_id, :node2_id, :outputtype, :outputvalue)
      else
        params.require(:extra_time_history).permit(:x1, :y1, :z1, :x2, :y2, :z2, :outputtype, :outputvalue)
      end
    end  
end
