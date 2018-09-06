classdef Queue < handle
    
    properties
        
        myLaneGroup @ DrawLaneGroup
        vehicles @ Vehicle
        
    end
    
    methods(Access=public)
        
        function this = Queue(myLaneGroup)
            this.myLaneGroup = myLaneGroup;
            this.vehicles = repmat(Vehicle,1,0);
        end
            
        function [this] = add_vehicle(this,vehicle)
            this.vehicles(end+1) = vehicle;
            this.draw();
        end
            
        function [this] = remove_vehicle(this,vehicle)
            ind = vehicle.id==[this.vehicles.id];
            this.vehicles(ind) = [];
            this.draw;
        end
        
        function []=draw(this)
            disp('OVERRIDE THIS!')
        end
        
    end
    
end

