class DefaultsController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods  
  def new
    if params[:analysis_id] != nil #Then its from Analysis
      @default = current_user.models(params[:model_id]).analyses(params[:analysis_id]).default.new
    else #Then its a default
      @default = current_user.profile.defaults.new 
    end
  end
  
  def edit
    @default = current_default
  end
  
  def update
    @default = current_default
    if @default.update(default_params)
      if params[:analysis_id] == nil
        current_user.profile.active_name = @default.name
        current_user.profile.save
      end
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end
  
  def show
    if params[:analysis_id] != nil #Then its from Analysis
      @model = current_user.models.find(params[:model_id])
      @analysis = @model.analyses.find(params[:analysis_id])
      @default = @analysis.default
    else
      @default = current_user.defaults.find(params[:id])
    end
  end
  
  def create
    if params[:analysis_id] == nil
        @default = current_user.profile.defaults.new(default_params)
    else
        @default = current_model.default.new(default_params)
    end
    
    
    if @default.save
      current_user.profile.active_name = @default.name
      current_user.profile.save

      tmp = ModelInformation.new
      tmp.default_id = @default.id
      tmp.save
      
      tmp = AnalysisOption.new
      tmp.default_id = @default.id
      tmp.save

      tmp = ConvergenceOption.new
      tmp.default_id = @default.id
      tmp.save

      tmp = FiberOption.new
      tmp.default_id = @default.id
      tmp.save
      
      tmp = VerticalConstraintOption.new
      tmp.default_id = @default.id
      tmp.save

      tmp = LoadOption.new
      tmp.default_id = @default.id
      tmp.save
      
      tmp = ResponseTimeHistoryOption.new
      tmp.default_id = @default.id
      tmp.save

      tmp = MaterialModel.new
      tmp.default_id = @default.id
      tmp.save

      tmp = FoundationNodeOption.new
      tmp.default_id = @default.id
      tmp.save
      
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end
  
  def destroy
    #Fix the active_name if youre looking at the default page
    if params[:analysis_id] == nil 
      @default = current_user.profile.defaults.find_by_id(params[:id])
      
      
      if current_user.profile.active_name == @default.name
        current_user.profile.active_name = nil
        current_user.profile.save
      end
      
      @default.destroy
    else
      current_default.destroy  
    end
    
    
    redirect_to user_path(current_user.id)
  end
  
  private
    def default_params
      params.require(:default).permit(:name)
    end  
end
