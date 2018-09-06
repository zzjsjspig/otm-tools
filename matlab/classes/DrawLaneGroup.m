classdef DrawLaneGroup < handle
    
    properties
        id
        lanes     % all lanes, including geom.addlanes
        geom @ Geom
        midline
        lanegroup_length
        lanegroup_width
        transition_queue @ TransitionQueue
        waiting_queue @ WaitingQueue
        
        vehicle_length
        vehicle_width
        gap
    end
    
    methods(Access=public)
        
        function this = DrawLaneGroup(lg,lanewidth,geom)
            if nargin>0
                this.id = lg.id;
                this.lanes = Java2Matlab(lg.lanes);
                this.geom = geom.get_geom_for_lanes(this.lanes);
                this.lanegroup_length = lg.length;
                this.lanegroup_width = numel(this.lanes) * lanewidth;
                this.transition_queue = TransitionQueue(this);
                this.waiting_queue = WaitingQueue(this);

                vehicle_space = lg.length / lg.max_vehicles;
                this.gap = 1; % [m]
                this.vehicle_length = vehicle_space - this.gap;
                this.vehicle_width = this.lanegroup_width * 0.8;

            end
        end
        
        function x = num_lanes(this)
            x = numel(this.lanes);
        end
        
        function []=draw(this,segments,lane_one_offset,lanewidth,lane2color)
            start_lane = min(this.lanes);
            offset = lane_one_offset + (start_lane - 1)*lanewidth;
            this.geom.draw( segments , ...
                offset , ...
                start_lane , ...
                lanewidth , ...
                lane2color );
            
            % compute midline
            dn = offset + this.num_lanes * lanewidth /2;
            this.midline = segments;
            for i=1:numel(segments)
                seg = segments(i);
                this.midline(i).start_p = seg.start_p + seg.n_start * dn;
                this.midline(i).end_p = seg.end_p + seg.n_end * dn;
                this.midline(i).length = sqrt( seg.length^2 +  2*dn*( seg.length*dot(seg.d,seg.n_end-seg.n_start) + dn*(1-dot(seg.n_start,seg.n_end)) ) );                
            end
            
        end
        
        function []=remove_vehicle_from_queue(this,vehicle,q)
            queue = this.get_queue(q);
            queue.remove_vehicle(vehicle);
        end
        
        function []=add_vehicle_to_queue(this,vehicle,q)
            queue = this.get_queue(q);
            queue.add_vehicle(vehicle);
        end
        
    end
    
    methods(Access=private)
        function queue = get_queue(this,q)
            switch q
                case 't'
                    queue = this.transition_queue;
                case 'w'
                    queue = this.waiting_queue;
                otherwise
                    disp(q)
            end
        end
    end
end

