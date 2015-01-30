class NsefbcFibersController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  
  #Methods
  def index
    @nsefbc_fibers = current_default.fiber_option.nsefbc_fibers
  end
  
  def show
    @nsefbc_fiber = current_default.fiber_option.nsefbc_fiber.find(params[:id])
  end
  
  def new
    @nsefbc_fiber = current_default.fiber_option.nsefbc_fibers.new
  end
  
  def edit
    @nsefbc_fiber = current_default.fiber_option.nsefbc_fibers.find(params[:id])
  end
  
  def update
    @nsefbc_fiber = current_default.fiber_option.nsefbc_fibers.find(params[:id])

    if @nsefbc_fiber.update(nsefbc_fiber_params)
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
    @nsefbc_fiber = current_default.fiber_option.nsefbc_fibers.new(nsefbc_fiber_params)
    if @nsefbc_fiber.save
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
    current_default.fiber_option.nsefbc_fibers.find(params[:id]).destroy
    redirect_to fiber_option_path(current_default.fiber_option.id)
  end
  
  private
    def nsefbc_fiber_params
      params.require(:nsefbc_fiber).permit(:number, :length)
    end  
end
