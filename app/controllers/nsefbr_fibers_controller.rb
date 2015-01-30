class NsefbrFibersController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def index
    @nsefbr_fibers = current_default.fiber_option.nsefbr_fibers
  end
  
  def show
    @nsefbr_fiber = current_default.fiber_option.nsefbr_fiber.find(params[:id])
  end
  
  def new
    @nsefbr_fiber = current_default.fiber_option.nsefbr_fibers.new
  end
  
  def edit
    @nsefbr_fiber = current_default.fiber_option.nsefbr_fibers.find(params[:id])
  end
  
  def update
    @nsefbr_fiber = current_default.fiber_option.nsefbr_fibers.find(params[:id])
    if @nsefbr_fiber.update(nsefbr_fiber_params)
      if params[:analysis_id] == nil
        save_path = fiber_option_path(current_default.fiber_option.id)
      else
        save_path = model_analysis_default_fiber_option_path(current_model.id, current_analysis.id, current_default.id, current_default.fiber_option.id)
      end
            
      redirect_to save_path
    else
      render :edit
    end
  end
  
  def create
    @nsefbr_fiber = current_default.fiber_option.nsefbr_fibers.new(nsefbr_fiber_params)
    if @nsefbr_fiber.update(nsefbr_fiber_params)
      if params[:analysis_id] == nil
        save_path = fiber_option_path(current_default.fiber_option.id)
      else
        save_path = model_analysis_default_fiber_option_path(current_model.id, current_analysis.id, current_default.id, current_default.fiber_option.id)
      end
            
      redirect_to save_path
    else
      render :new
    end
  end
  
  def destroy
    current_default.fiber_option.nsefbr_fibers.find(params[:id]).destroy
    redirect_to fiber_option_path(current_default.fiber_option.id)
  end
  
  private
    def nsefbr_fiber_params
      params.require(:nsefbr_fiber).permit(:number, :length)
    end  
end
