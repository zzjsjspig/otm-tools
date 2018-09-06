classdef TransitionQueue < Queue
    
    properties
    end
    
    methods(Access=public)
        
        function this = TransitionQueue(myLaneGroup)
            this@Queue(myLaneGroup)
        end
        
        % start from the last vehicle, draw from the begining of the
        % midline forward
        function []=draw(this)
            
            % dont draw the transition queue
            return;
            
            step = this.myLaneGroup.vehicle_length + this.myLaneGroup.gap;
            cum_length = [0 cumsum([this.myLaneGroup.midline.length])];
            
            pos = 0;
            for i=numel(this.vehicles):-1:1
                
                v = this.vehicles(i);
                
                ind = find(pos<cum_length,1,'first')-1;
                if ~isempty(ind)
                    seg = this.myLaneGroup.midline(ind);
                    rpos = pos - cum_length(ind);
                    v.draw(seg.start_p + rpos * seg.d,seg.d,this.myLaneGroup.vehicle_length,this.myLaneGroup.vehicle_width);
                else
                    break
                end
                
                % advance position
                pos = pos + step;
            end
            
        end
        
    end
    
end

