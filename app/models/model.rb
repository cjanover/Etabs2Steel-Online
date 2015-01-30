class Model < ActiveRecord::Base
  #Callbacks
  after_create :parse_file
  after_destroy :cleanup
  
  #Dependencies
  belongs_to :user

  has_many :floors, dependent: :destroy
  has_many :points, dependent: :destroy
  has_many :nodes, dependent: :destroy
  has_many :load_combos, dependent: :destroy
  
  has_many :analyses, dependent: :destroy
  
  
  private
    def cleanup
      #Cleanup Floors, Points, Nodes, and Load Combos
      self.floors.destroy
      self.points.destroy
      self.nodes.destroy
      self.load_combos.destroy
    end
  
  
    def parse_file
      #Parse through the file
      File.open(File.join(Rails.root,'public',self.user_id.to_s,self.name,self.e2k_file)).each do |line|
        #Check for Floors
        if /^\s+STORY\s+\"(.+)\"\s+(\w+)\s+([^\s]+).+/.match(line)
          floor = Floor.new(:model_id => self.id, :name => $1, :elevation => $3)
          floor.model_id = self.id
          floor.save
        end
        
        #Check for Points
        if /^\s+POINT\s+\"(\d+)\"\s+([^\s]+)\s([^\s]+)/.match(line)
          point = Point.new(:model_id => self.id, :name => $1, :X => $2, :Y => $3)
          point.model_id = self.id
          point.save
        end
          
        #Check for Nodes
        if /\s+POINTASSIGN\s+\"(\d+)\"\s+\"(\w+)\".+/.match(line)
          node = Node.new(:model_id => self.id, :point_name => $1, :floor_name => $2)
          node.model_id = self.id
          
          #Get X, Y, and Z Coords
          node.X = self.points.where(name: $1).first.X
          node.Y = self.points.where(name: $1).first.Y
          node.Z = self.floors.where(name: $2).first.elevation
          node.save
        end
          
        #Check for Load Combos
        if /\s+COMBO\s\"(.+)\"\s+TYPE\s+\"(.+)\"\s*(SF)?\s*(.+)?/.match(line)
          load_combo = LoadCombo.new(:model_id => self.id, :case_name => $1)
          load_combo.model_id = self.id
          load_combo.save
        end
      end
    end
end
