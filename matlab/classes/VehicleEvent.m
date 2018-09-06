classdef VehicleEvent < Event
    
    properties(Access=public)
        vehicle
        from_lanegroup
        from_queue
        to_lanegroup
        to_queue
    end
    
    methods
        
        function this = VehicleEvent(time,vehicle_id,from_queue,to_queue)
            this = this@Event(time);
            if nargin<2
                return
            end
            this.vehicle = double(vehicle_id);
            if strcmp(from_queue,'-')
                this.from_queue = '';
                this.from_lanegroup = nan;
            else
                this.from_queue = from_queue.charAt(0);
                this.from_lanegroup = str2double(from_queue.substring(1));
            end
            if strcmp(to_queue,'-')
                this.to_queue = '';
                this.to_lanegroup = nan;
            else
                this.to_queue = to_queue.charAt(0);
                this.to_lanegroup = str2double(to_queue.substring(1));
            end
        end
        
    end
    
end

