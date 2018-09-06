classdef AddLanes < handle
    
    properties
        side
        num_lanes
        length
    end
    
    methods
        
        function this = AddLanes(addlanes)
            if isempty(addlanes)
                this.num_lanes = 0;
                return
            end
            this.side = addlanes.side;
            this.num_lanes = addlanes.lanes;
            this.length = addlanes.length;

        end
        
        function [offset,start_lane]=draw(this,segments,offset,link_length,start_lane,lanewidth,lane2color)
            
            width = lanewidth*this.num_lanes;
            end_lane = start_lane + this.num_lanes-1;
            
            LineDrawer.plot_line_for_points( ...
                segments , ...
                offset , ...
                link_length - this.length , ...
                link_length , ...
                width , ...
                lane2color(start_lane:end_lane) );

            offset = offset + width;
            start_lane = end_lane+1;
        end
         
    end
    
end

