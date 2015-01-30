require 'net/ftp'

class AnalysesController < ApplicationController
  #Callbacks
  before_action :authenticate, except: [:index, :show]
  #Methods
  def show
    @model = current_user.models(params[:model_id])
    @analysis = @model.analyses(params[:analysis_id])
    @default = @analysis.defaults(params[:id])    
  end
  
  def create
    @analysis = current_user.models.find(params[:model_id]).analyses.new(analysis_params)
    
    if @analysis.save 
      copy_defaults(@analysis)
      redirect_to model_path(params[:model_id])
    else
      render action: :new
    end
  end
  
  def new
    @model = current_user.models.find(params[:model_id])
    @analysis = Analysis.new
  end
  
  def edit
    @model = current_user.models.find(params[:model_id])
    @analysis = current_user.models.find(params[:model_id]).analyses.find(params[:id])
  end
  
  def update
    @analysis = current_user.models.find(params[:model_id]).analyses.find(params[:id])
    if @analysis.update(analysis_params)
      redirect_to model_path(params[:model_id]), :notice => "New Analysis Created"
    else
      render action: :new
    end
  end
  
  def destroy
    current_user.models.find(params[:model_id]).analyses.find(params[:id]).destroy
    redirect_to model_path(params[:model_id])
  end
  
  def submit
    @model = current_user.models.find(params[:model_id])
    @analysis = @model.analyses.find(params[:id])
    @default = @analysis.default
    
    #Create config file
    filename = @default.model_information.title
        
    file_name_path = File.join(Rails.root,'public',current_user.id.to_s,@model.name,filename,"Etabs2Steel.config")

    unless File.exist?(File.dirname(file_name_path))
      FileUtils.mkdir_p(File.dirname(file_name_path))
    end
    file_handle = open(file_name_path, 'w')
    
    #Introduction
    file_handle.write("% Config File for Etabs2Steel\n")
    file_handle.write("\n\n")
    file_handle.write("% All characters following % until carrige return are ignored\n")
    file_handle.write("% All whitespace is ignored\n")
    file_handle.write("\n")
    file_handle.write("% Config option name surrounded by '[]' and must be written in quotes\n")
    file_handle.write("\n")
    
    # Program output Information
    file_handle.write("%%%%%%%%%%%%%   Program Output Information   %%%%%%%%%%%%%\n")
    file_handle.write("[DEBUGLEVEL] "+ @default.analysis_option.debuglevel.to_s + "                                                      % 0 = Only Errors, 1 = Element Creation, 2 = Parsing Info, 3 = All Debug Info" + "\n")
    file_handle.write("[SECTIONCONVERSION] "+@default.analysis_option.sectionconversion.to_s + "                                             % Toggle to enable or disbale output of section conversion table (yes or no)" + "\n")
    file_handle.write("[MATCONVERSION] "+@default.analysis_option.matconversion.to_s + "                                                 % Toggle to enable or disable output of material conversion table (yes or no)" + "\n")
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Model Information   %%%%%%%%%%%%%\n")
    file_handle.write("[TITLE] " + @default.model_information.title + "                                                 % Title of Model (Name output data will be saved to)" + "\n")
    file_handle.write("[SAVELOC] " + "FIX THIS" + "     % Location where Input and Output Files will be saved to (dont include trailing / in directory)" + "\n")
    file_handle.write("[ETABSTITLE] " + "FIX THIS"  + "                                                 % Title of Etabs File (Name of e2k file to be read from)" + "\n")
    file_handle.write("[ETABSLOC] " + "FIX THIS" + "    % Location of Etabs Input File (dont include trailing / in directory)" + "\n")
    file_handle.write("[PRIMARYETABSDIR] " + @default.model_information.primaryetabsdir + "                                                        % Direction in the ETabs model to use for pirmary frames" + "\n")
    file_handle.write("[STEELSECTION] " + @default.model_information.steelsection + "                                                  % Section Database (Use Capitol X,Y,Z)" + "\n")
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Analysis Options   %%%%%%%%%%%%%\n")
    file_handle.write("[PanelZoneRigidity] " + @default.analysis_option.panel_zone_rigidity.to_s + "                    % Rigidity of Panel Zones at non-fixed points (1 = Rigid, 2 = Flexible)" + "\n")
    file_handle.write("[MTP] " + @default.analysis_option.mtp.to_s + "                                % Maximum number of turning points in Hysteretic Models (use 20)" + "\n")
    file_handle.write("[NDIM] " + @default.analysis_option.ndim.to_s + "                           % Maximum number of turning point locations (Use 100000)" + "\n")
    file_handle.write("[NSS] " + @default.analysis_option.nss.to_s + "                                % Number of static load steps" + "\n")
    file_handle.write("[BETA] " + @default.analysis_option.beta.to_s + "                             % Newmark Integration Parameter (0 = Central Difference, 0.25 = Const Average, 0.166 = Linear Average)" + "\n")
    file_handle.write("[GAMMA] " + @default.analysis_option.gamma.to_s + "                             % Newmark Integration Parameter (0.5)" + "\n")
    file_handle.write("[A0] " + @default.analysis_option.a0.to_s + "                                  % Damping Parameter (C = A0*M + A1*K) (Assumed to be 0 when using special columns to model damping)" + "\n")
    file_handle.write(@default.analysis_option.first_mode_period = nil ? "%" : "" + "[FIRSTMODEPERIOD] " + @default.analysis_option.first_mode_period.to_s + "                      % Period of the first mode of the structure. If left blank program assumes T = 0.1*N where N is the number of stories" + "\n")
    file_handle.write("[DAMPINGRATIOSTIFF] " + @default.analysis_option.damping_ratio_stiffness.to_s + "% Stiffness Proportional Rayleigh Damping Value. Used to calculate A1 via A1 = 2*Csi_k/w_1 where w_1 above (Assumed to be 0.005 when using special columns to model damping)" + "\n")
    file_handle.write("[DAMPINGRATIOCOL] " + @default.analysis_option.damping_ratio_column.to_s + "% Damping Ratio of Columns for calculation of A2" + "\n")
    file_handle.write("[BASESHEARPERCENT] " + @default.analysis_option.base_shear_percent.to_s + "                  % Percent of values used to calculate A2 = Fraction*R*Drift*Wn/(2*eta_n_c) (Default is 0.1)" + "\n")
    file_handle.write("[BASESHEAR] " + @default.analysis_option.base_shear.to_s + "                        % Pushover Base Shear" + "\n")
    file_handle.write("[R] " + @default.analysis_option.r.to_s + "                                 % Ratio between F_push and F_eq_des (F_push/F_eq_des) Must run pushover analyes to determine ratio (Hall says 2.5)" + "\n")
    file_handle.write(@default.analysis_option.base_drift = nil ? "%" : "" + "[BASEDRIFT] " + @default.analysis_option.base_drift.to_s + "                        % Drift of the base floor, shoudl use ETabs model to determine quanitity (Default is 1/400*Story_Height)" + "\n")
    file_handle.write("[DT] " + @default.analysis_option.dt.to_s + "                              % Time Step for dynamic analysis (Only used if no EQ data is provided)" + "\n")
    file_handle.write("[IRINT] " + @default.analysis_option.irint.to_s + "                               % Output interval for response time histories on unit 8 (1 means every step, 2 means every other)" + "\n")
    file_handle.write("[IROUT] " + @default.analysis_option.irout.to_s + "                               % Toggle to also output response time histories to unit 4 (1 = yes, 0 = no)" + "\n")
    file_handle.write(@default.analysis_option.istop = nil ? "%" : "" + "[ISTOP] " + @default.analysis_option.istop.to_s + "                             % ISTOP time step at which current dynamic analysis ends (If empty then uses NDS)" + "\n")
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Convergence Options   %%%%%%%%%%%%%\n")
    file_handle.write("[MIG] " + @default.convergence_option.mig.to_s + "                                % Maximum number of global iterations (Use 20)" + "\n")
    file_handle.write("[TOL1] " + @default.convergence_option.tol1.to_s + "                              % Force Tolerance for global iterations" + "\n")
    file_handle.write("[TOL3] " + @default.convergence_option.tol3.to_s + "                              % Moment Tolerance for global iterations" + "\n")
    file_handle.write("[TOL5] " + @default.convergence_option.tol5.to_s + "                              % Force Tolerance for local iterations" + "\n")
    file_handle.write("[TOL7] " + @default.convergence_option.tol7.to_s + "                                % Moment tolerance for local iterations" + "\n")
    file_handle.write("[ALPHAC] " + @default.convergence_option.alphac.to_s + "                      % Connection Element Stiffness" + "\n")
    file_handle.write("[A3] " + @default.convergence_option.a3.to_s + "                                  % Multiplier of yield strength of Floor-to-Floor spring to give yield strength of floor-to-floor shear dampers" + "\n")
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Vertical Constraint Options   %%%%%%%%%%%%%\n")
    file_handle.write("%%In this area the value of alphavc for the vertical connection element stiffness is inputed using the following form\n")
    file_handle.write("        % [ALPHAVC] (x, y, z) alphavc\n")
    file_handle.write("            %where (x, y, z1) are the coordinates of the column to be given a vertical stiffness of alphavc\n")
    file_handle.write("% additionally an entry of\n")
    file_handle.write("        %[ALPHAVCDEF] alphavc\n")
    file_handle.write("            %must exist where alphavc is the vertical stiffness to be given to all column elements which do not have a specific stiffness given\n")
    file_handle.write("[ALPHAVCDEF] " + @default.vertical_constraint_option.alphavcdef.to_s + "\n")
    @default.vertical_constraint_option.vertical_constraint.each do |vc|
      file_handle.write("[ALPHAVC] (" + vc.x.to_s + ", " + vc.y.to_s + ", " + vc.z.to_s + ") " + vc.alphavc.to_s + "\n")
    end
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Fiber Options   %%%%%%%%%%%%%\n")
    file_handle.write("[EEC] " + @default.fiber_option.eec.to_s + "                              % Axial Load Eccentricity factor for braces\n")
    file_handle.write("[NSEFBC] " + @default.fiber_option.nsefbc.to_s + "                              % Number of fiber segments for beam or column (Use 8)\n")
    file_handle.write("[NSEFBR] " + @default.fiber_option.nsefbr.to_s + "                              % Number of Fiber Segments for Braces (Use 7)\n")
    file_handle.write("[MILF] " + @default.fiber_option.milf.to_s + "                               % Maximum number of element iterations (Use 20)\n")
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Load Options   %%%%%%%%%%%%%\n")
    file_handle.write("[LOADCOMBO] " + @default.load_option.load_combo.to_s + "                 % Name of ETABS load combination to use for loads on steel model (Do not use combinations of combinations)\n")
    file_handle.write("[MASSCOMBO] " + @default.load_option.mass_combo.to_s + "                        % Name of ETABS load combination to use for mass on steel model (Do not use combinations of combinations)\n")
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Extra Response Time Histories   %%%%%%%%%%%%%\n")
    file_handle.write("%In this area extra response time histories are place. Etabs2Steel automatically outputs displacement time history \n")
    file_handle.write("%   of every node in the building if enabled.\n")
    file_handle.write("[PlotAll] " + @default.response_time_history_option.plotall.to_s + "                             % Toggle for plotting displacements of every node (1 = yes, 0 = no)\n")
    file_handle.write("[PlotSecondary] " + @default.response_time_history_option.plotsecondary.to_s + "                       % Searches through secondary direction for nodes matching coordinates of primary (1 = yes, 0 = no)\n")
    file_handle.write("\n")
    file_handle.write("%Extra time histories in the form\n")
    file_handle.write("    %[ExTH] (x1, y1, z1) (x2, y2, z2) OutputType OutputValue\n")
    file_handle.write("\n")
    file_handle.write("    %Where      (x1, y1, z1) are the Etabs Coordinates of the first node for the time history (Required)\n")
    file_handle.write("    %           (x2, y2, z2) are the Etabs Coordinates of the second node for the time history (Required for element base output)\n")
    file_handle.write("    %           OutputType      1 = Nodal Response History\n")
    file_handle.write("    %                                   OutputValue      1 = Steel X Direction\n")
    file_handle.write("    %                                                    2 = Steel Y Direction\n")
    file_handle.write("    %                                                    3 = Beam Rotation\n")
    file_handle.write("    %                                                    4 = Column Rotation\n")
    file_handle.write("    %                           2 = Panel Zone History\n")
    file_handle.write("    %                                   OutputValue      1 = Panel Zone Moment\n")
    file_handle.write("    %                                                    2 = Panel Zone Plastic Rotation\n")
    file_handle.write("    %                           3 = Beam/Column/Brace Element History\n")
    file_handle.write("    %                                   OutputValue      1 = Moment At Node 1 (According to Config Input)\n")
    file_handle.write("    %                                                    2 = Moment at Node 2 (According to Config Input)\n")
    file_handle.write("    %                                                    3 = Plastic Rotation at Node 1 (According to Config Input)\n")
    file_handle.write("    %                                                    4 = Plastic Rotation at Node 2 (According to Config Input)\n")
    file_handle.write("    %                                                    5 = Axial Force in Element\n")
    file_handle.write("    %                                                    6 = Plastic Axial Displacement in Element\n")
    @default.response_time_history_option.extra_time_histories.each do |th|
      file_handle.write("[ExTH] (" + th.x1.to_s + ", " + th.y1.to_s + ", " + th.z1.to_s + ") ")
      
      if (th.outputtype == 3)
        file_handle.write("(" + th.x2.to_s + ", " + th.y2.to_s + ", " + th.z2.to_s + ") ")
      end
      file_handle.write(th.outputtype.to_s + " " + th.outputvalue.to_s + "\n")
    end
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Material Models   %%%%%%%%%%%%%\n")
    file_handle.write("    %Add Explination\n")
    file_handle.write("[SteelMat] " + @default.material_model.steelmat_G.to_s + " " + @default.material_model.steelmat_Sy.to_s + "           % Shear Modulus of Steel and Shear Yield Stress of Steel\n")
    file_handle.write("[DefWallShearMod] " + @default.material_model.defwallshearmod.to_s + "          % Default Shear Modulus to use for Basement Wall Elements\n")
    file_handle.write("[NumMaterial] 2                         % Number of Material Models, Default is 2\n")
    file_handle.write("    %Matial Input of the form   [MAT] E ES SIGY SIGU EPSS EPSU PRAT RES\n")
    file_handle.write("                            %Where\n")
    file_handle.write("                                    %E      Youngs Modulus for Material I for Beam/Col/Brace Elements\n")
    file_handle.write("                                    %ES     Initial Strain Hardening Modulus ...\n")
    file_handle.write("                                    %SIGY   Yield Stress ...\n")
    file_handle.write("                                    %SIGU   Ultimate Stress\n")
    file_handle.write("                                    %EPSS   Strain at onset of Strain hardening ...\n")
    file_handle.write("                                    %EPSU   Strain at Peak Stress ...\n")
    file_handle.write("                                    %PRAT   Poisson's Ratio\n")
    file_handle.write("                                    %RES    Residual Stress\n")
    file_handle.write("[MAT] " + @default.material_model.mat_1_E.to_s + " " + @default.material_model.mat_1_ES.to_s + " " + @default.material_model.mat_1_SIGY.to_s + " " + @default.material_model.mat_1_SIGU.to_s + " " + @default.material_model.mat_1_EPSS.to_s + " " + @default.material_model.mat_1_EPSU .to_s+ " " + @default.material_model.mat_1_PRAT.to_s + " " + @default.material_model.mat_1_RES.to_s + "\n")
    file_handle.write("[MAT] " + @default.material_model.mat_2_E.to_s + " " + @default.material_model.mat_2_ES.to_s + " " + @default.material_model.mat_2_SIGY.to_s + " " + @default.material_model.mat_2_SIGU.to_s + " " + @default.material_model.mat_2_EPSS.to_s + " " + @default.material_model.mat_2_EPSU.to_s + " " + @default.material_model.mat_2_PRAT.to_s + " " + @default.material_model.mat_2_RES.to_s + "\n")
    file_handle.write("\n")
    file_handle.write("%Concrete Material Properties\n")
    file_handle.write("[ConcreteMat] " + @default.material_model.concretemat_E.to_s + " " + @default.material_model.concretemat_CS.to_s + " " + @default.material_model.concretemat_PCT.to_s + "      % Modulus   Crushing Stress     Percentage of Crushing for Tension\n")
    file_handle.write("\n")
    file_handle.write("[MATERIALCONV] " + @default.material_model.materialconv1 + "1               % Conversion between ETABS material and Steel Material\n")
    file_handle.write("[MATERIALCONV] " + @default.material_model.materialconv2 + "2               % Conversion between ETABS material and Steel Material\n")
    file_handle.write("[MATERIALCONV] " + @default.material_model.materialconv3 + "0               % Conversion between ETABS material and Concrete Material\n")
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Foundation Nodes   %%%%%%%%%%%%%\n")
    file_handle.write("%Need to give properties for foundation nodes, Input must be given for a default and for any specific springs\n")
    file_handle.write("    % [DefFndNode] ALP STRH STRVU STRVD\n")
    file_handle.write("        %or\n")
    file_handle.write("    % [FndNode] Name ALP STRH STRVU STRVD\n")
    file_handle.write("        %Where\n")
    file_handle.write("            % Name      Name of Spring Element in Etabs\n")
    file_handle.write("            % ALP       Post-Yield Stiffness Ratio for Foundation Springs\n")
    file_handle.write("            % Yield Strength of Horizontal Spring\n")
    file_handle.write("            % Yield Strength of Vertical Spring in Upward Direction\n")
    file_handle.write("            % Yield Strength of Vertical Spring in Downward Direction\n")
    file_handle.write("[DefFndNode] " + @default.foundation_node_option.ALP.to_s + " " + @default.foundation_node_option.STRH.to_s + " " + @default.foundation_node_option.STRVU.to_s + " " + @default.foundation_node_option.STRVD.to_s + "\n")
    @default.foundation_node_option.foundation_nodes.each do |fn|
      file_handle.write("[FndNode] " + fn.name + " " + fn.ALP.to_s + " " + fn.STRH.to_s + " " + fn.STRVU.to_s + " " + fn.STRVD.to_s + "\n")
    end
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   IPC, FRAC segment lengths Beam/Col Elements   %%%%%%%%%%%%%\n")
    file_handle.write("%Represent Segment lenghts for Beams and Column Elements input of the form\n")
    file_handle.write("    %[FRAC-BC] val1 len1\n")
    file_handle.write("    %[FRAC-BC] val2 len2\n")
    file_handle.write("    %...\n")
    file_handle.write("    %[FRAC-BC] 0 0\n")
    file_handle.write("%Final row must be 0 0, default is\n")
    file_handle.write("    %[FRAC-BC] 1 0.03\n")
    file_handle.write("    %[FRAC-BC] 1 0.06\n")
    file_handle.write("    %[FRAC-BC] 1 0.16\n")
    file_handle.write("    %[FRAC-BC] 2 0.25\n")
    file_handle.write("    %[FRAC-BC] 1 0.16\n")
    file_handle.write("    %[FRAC-BC] 1 0.06\n")
    file_handle.write("    %[FRAC-BC] 1 0.03\n")
    file_handle.write("    %[FRAC-BC] 0 0\n")
    @default.fiber_option.nsefbc_fibers.each do |f|
      file_handle.write("[FRAC-BC] " + f.number.to_s + " " + f.length.to_s + "\n")
    end
    file_handle.write("[FRAC-BC] 0 0\n")
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   IPC, FRAC segment lengths Brace Elements   %%%%%%%%%%%%%\n")
    file_handle.write("%Represent Segment lenghts for Brace Elements input of the form\n")
    file_handle.write("    %[FRAC-BR] val1 len1\n")
    file_handle.write("    %[FRAC-BR] val2 len2\n")
    file_handle.write("    %...\n")
    file_handle.write("    %[FRAC-BR] 0 0\n")
    file_handle.write("%Final row must be 0 0, default is\n")
    file_handle.write("    %[FRAC-BR] 1 0.25\n")
    file_handle.write("    %[FRAC-BR] 1 0.16\n")
    file_handle.write("    %[FRAC-BR] 1 0.07\n")
    file_handle.write("    %[FRAC-BR] 1 0.04\n")
    file_handle.write("    %[FRAC-BR] 1 0.07\n")
    file_handle.write("    %[FRAC-BR] 1 0.16\n")
    file_handle.write("    %[FRAC-BR] 1 0.25\n")
    file_handle.write("    %[FRAC-BR] 0 0\n")
    @default.fiber_option.nsefbr_fibers.each do |f|
      file_handle.write("[FRAC-BR] " + f.number.to_s + " " + f.length.to_s + "\n")
    end
    file_handle.write("[FRAC-BR] 0 0\n")
    file_handle.write("\n")
    
    file_handle.write("%%%%%%%%%%%%%   Ground Acceleration Multiplier   %%%%%%%%%%%%%\n")
    file_handle.write("%Scale factor for ground accelerations. Uncomment to overide ETABS value\n")
    file_handle.write("[GAMULT] " + @default.load_option.gamult.to_s + "\n")
    
    
    
    #Upoad file to the FTP site
    file_name_path = File.join(Rails.root,'public',current_user.id.to_s,@model.name,filename,"Etabs2Steel.config")




    ftp = Net::FTP.new('10.0.1.6')
    ftp.login
    
    begin
      ftp.chdir(File.dirname(file_name_path))
    rescue Net::FTPPermError
      ftp.mkdir('test')
    end
    
  end
    

  
  private
    def copy_defaults(analysis)
      #Create Associated Default
      anal_def = Default.create(:name => current_user.profile.active_name, :config_id => analysis.id, :config_type => "Analysis")


      if (current_default != nil)
        tmp = ModelInformation.new(current_default.model_information.attributes)
        tmp.id = nil
        tmp.default_id = anal_def.id
        tmp.save
      
        tmp = AnalysisOption.new(current_default.analysis_option.attributes)
        tmp.id = nil
        tmp.default_id = anal_def.id
        tmp.save

        tmp = ConvergenceOption.new(current_default.convergence_option.attributes)
        tmp.id = nil
        tmp.default_id = anal_def.id
        tmp.save

        tmp = FiberOption.new(current_default.fiber_option.attributes)
        tmp.id = nil
        tmp.default_id = anal_def.id
        tmp.save
        
          current_default.fiber_option.nsefbc_fibers.each do |f|
            tmp = NsefbcFiber.new(f.attributes)
            tmp.id = nil
            tmp.fiber_option_id = anal_def.fiber_option.id
            tmp.save
          end
          current_default.fiber_option.nsefbr_fibers.each do |f|
            tmp = NsefbrFiber.new(f.attributes)
            tmp.id = nil
            tmp.fiber_option_id = anal_def.fiber_option.id
            tmp.save
          end
        
      
          tmp = VerticalConstraintOption.new(current_default.vertical_constraint_option.attributes)
          tmp.id = nil
          tmp.default_id = anal_def.id
          tmp.save
        
          current_default.vertical_constraint_option.vertical_constraint.each do |f|
            tmp = VerticalConstraint.new(f.attributes)
            tmp.id = nil
            tmp.vertical_constraint_option_id = anal_def.vertical_constraint_option.id
            tmp.save
          end

          tmp = LoadOption.new(current_default.load_option.attributes)
          tmp.id = nil
          tmp.default_id = anal_def.id
          tmp.save
      
          tmp = ResponseTimeHistoryOption.new(current_default.response_time_history_option.attributes)
          tmp.id = nil
          tmp.default_id = anal_def.id
          tmp.save

          current_default.response_time_history_option.extra_time_histories.each do |f|
            tmp = ExtraTimeHistory.new(f.attributes)
            tmp.id = nil
            tmp.response_time_history_option_id = anal_def.response_time_history_option.id
            tmp.save
          end
        
          tmp = MaterialModel.new(current_default.material_model.attributes)
          tmp.id = nil
          tmp.default_id = anal_def.id
          tmp.save

          tmp = FoundationNodeOption.new(current_default.foundation_node_option.attributes)
          tmp.id = nil
          tmp.default_id = anal_def.id
          tmp.save
      
          current_default.foundation_node_option.foundation_nodes.each do |f|
            tmp = FoundationNode.new(f.attributes)
            tmp.id = nil
            tmp.foundation_node_option_id = anal_def.foundation_node_option.id
            tmp.save
          end
        else
          tmp = ModelInformation.new
          anal_def.model_information = tmp
          tmp.save
          
          tmp = AnalysisOption.new
          anal_def.analysis_option = tmp
          tmp.save
          
          tmp = ConvergenceOption.new
          anal_def.convergence_option = tmp
          tmp.save
          
          tmp = FiberOption.new
          anal_def.fiber_option = tmp
          tmp.save
          
          tmp = VerticalConstraintOption.new
          anal_def.vertical_constraint_option = tmp
          tmp.save
          
          tmp = LoadOption.new
          anal_def.load_option = tmp
          tmp.save
          
          tmp = ResponseTimeHistoryOption.new
          anal_def.response_time_history_option = tmp
          tmp.save
          
          tmp = MaterialModel.new
          anal_def.material_model = tmp
          tmp.save
          
          tmp = FoundationNodeOption.new
          anal_def.foundation_node_option = tmp
          tmp.save
        end
    end
  
    def analysis_params
      params.require(:analysis).permit(:name)
    end 
end
