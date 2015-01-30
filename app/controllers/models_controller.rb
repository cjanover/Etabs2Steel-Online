require 'fileutils'

class ModelsController < ApplicationController
  before_action :authenticate, except: [:index, :show]

  # GET /models
  # GET /models.json
  def index
    @models = current_user.models
  end

  # GET /models/1
  # GET /models/1.json
  def show
    @model = current_user.models.find(params[:id])
  end

  # GET /models/new
  def new
    @model = Model.new
  end

  # GET /models/1/edit
  def edit
  end

  # POST /models
  # POST /models.json
  def create
    @model = Model.new(model_params)
    @model.user_id = current_user.id
    
    file = model_params[:e2k_file].read
    filename = model_params[:e2k_file].original_filename
        
    file_name_path = File.join(Rails.root,'public',current_user.id.to_s,@model.name,filename)

    unless File.exist?(File.dirname(file_name_path))
      FileUtils.mkdir_p(File.dirname(file_name_path))
    end
    File.open(file_name_path, 'wb') {|f| f.write file}
    
    @model.e2k_file = filename
    
    respond_to do |format|
      if @model.save
        format.html { redirect_to @model, notice: 'Model was successfully created.' }
        format.json { render :show, status: :created, location: @model }
      else
        format.html { render :new }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /models/1
  # PATCH/PUT /models/1.json
  def update
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to @model, notice: 'Model was successfully updated.' }
        format.json { render :show, status: :ok, location: @model }
      else
        format.html { render :edit }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.json
  def destroy
    set_model
    @model.destroy
    respond_to do |format|
      format.html { redirect_to models_path, notice: 'Model was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Model.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_params
      params.require(:model).permit(:name, :e2k_file)
    end
end
