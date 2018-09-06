classdef Geom < handle
    
    properties
        left_addlane @AddLanes
        right_addlane @AddLanes
        full_length
        full_lanes
        lane2addlane        % 0: left, 1: full, 2: right
    end
    
    methods(Access=public)
        
        function [this] = Geom(link)
            
            if nargin==0
                return
            end
                
            this.full_length = link.full_length;
            this.full_lanes = link.full_lanes;
            
            % extract info for link ..................................
            if ~isempty(link.road_geom) 
                if link.road_geom.up_left.lanes>0 || link.road_geom.up_right.lanes>0
                    error('not implemented')
                end
                
                if link.road_geom.dn_left.lanes>0
                    this.left_addlane = AddLanes(link.road_geom.dn_left);
                end

                if link.road_geom.dn_right.lanes>0
                    this.right_addlane = AddLanes(link.road_geom.dn_right);
                end
            end
            
                
%             if isfield(link.ATTRIBUTE,'roadgeom')
%                 add_lanes = viz.roadgeom_addlanes{viz.roadgeom_ids==link.ATTRIBUTE.roadgeom};
%                 sides = arrayfun(@(z) z.ATTRIBUTE.side , add_lanes, 'UniformOutput', false);
%                 if sum(strcmp(sides,'l'))>1 || sum(strcmp(sides,'r'))>1
%                     error('currently does not support mutliple addlanes on one side')
%                 end
%                 this.left_addlane = AddLanes(add_lanes(strcmp(sides,'l')));
%                 this.right_addlane = AddLanes(add_lanes(strcmp(sides,'r')));
%             end
            
            % map from lane to addlane or full lane
            this = this.compute_lane2addlane;

        end
        
        function [n] = get_num_total_lanes(this)
            n = this.get_num_left_addlanes + this.full_lanes + this.get_num_right_addlanes;
        end
        
        function [n] = get_num_left_addlanes(this)
            if ~isempty(this.left_addlane) && this.left_addlane.num_lanes>0
                n=this.left_addlane.num_lanes;
            else 
                n=0;
            end
        end
            
        function [n] = get_num_right_addlanes(this)
            if ~isempty(this.right_addlane) && this.right_addlane.num_lanes>0
                n=this.right_addlane.num_lanes;
            else 
                n=0;
            end
        end

        % cut out a new geometry from this geometry along these lanes.
        % the given lane numbers are relative to this geometry, so they
        % do not correspond to actual lane numbers in the link
        function newgeom = get_geom_for_lanes(this,newgeom_lanes)
            newgeom = Geom();
            
            c = this.lane2addlane(newgeom_lanes);
            
            % has a left add lane
            if ismember(0,c)  
                newgeom.left_addlane = this.left_addlane;
                newgeom.left_addlane.num_lanes = sum(c==0);
            end
            
            % full lanes
            newgeom.full_length = this.full_length;
            newgeom.full_lanes = sum(c==1);
            
            % has a right add lane
            if ismember(2,c)  
                newgeom.right_addlane = this.right_addlane;
                newgeom.right_addlane.num_lanes = sum(c==2);
            end
            
            % map from lane to addlane or full lane
            newgeom = newgeom.compute_lane2addlane;
        end
            
        function []=draw(this,segments,offset,start_lane,lanewidth,lane2color)
            
            % draw left add_lanes ................................
            if ~isempty(this.left_addlane)
                for add_lane = this.left_addlane
                    [offset,start_lane] = add_lane.draw(segments , ...
                                  offset , ...
                                  this.full_length , ...
                                  start_lane , ...
                                  lanewidth , ...
                                  lane2color );
                end
            end
            
            % full lanes ..........................................
            width = this.full_lanes*lanewidth;
            end_lane = start_lane + this.full_lanes-1;
            h = LineDrawer.plot_line_for_points( ...
                segments , ...
                offset , ...
                0 , ...
                1 , ...
                width , ...
                lane2color(start_lane:end_lane) );
            offset = offset + width;
            start_lane = end_lane + 1;
            
            % draw right add_lanes ...............................
            if ~isempty(this.right_addlane)
                for add_lane = this.right_addlane
                    [offset,start_lane] = add_lane.draw(segments , ...
                        offset , ...
                        this.full_length , ...
                        start_lane , ...
                        lanewidth , ...
                        lane2color );
                end
            end
            
        end
        
    end
    
    methods(Access=private)
       
        function [this]=compute_lane2addlane(this)
            this.lane2addlane = ones(1,this.get_num_total_lanes);
            if this.get_num_left_addlanes>0
                this.lane2addlane(1:this.get_num_left_addlanes) = 0;
            end
            if this.get_num_right_addlanes>0
                this.lane2addlane(end-this.get_num_right_addlanes+1:end) = 2;
            end
        end
        
    end
    
end

