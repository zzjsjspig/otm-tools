
classdef WaitingQueue < Queue
    
    properties
    end
    
    methods(Access=public)
        
        function this = WaitingQueue(myLaneGroup)
            this@Queue(myLaneGroup)
        end
        
        
        % start from the first vehicle, draw from the end of the midline backwards
        function []=draw(this)
            
            step = this.myLaneGroup.vehicle_length + this.myLaneGroup.gap;
            cum_length = [0 cumsum([this.myLaneGroup.midline.length])];
            
            pos = cum_length(end)-this.myLaneGroup.vehicle_length;
            for i=1:numel(this.vehicles)
               
                v = this.vehicles(i);
                                        
                ind = find(pos<cum_length,1,'first')-1;
                if ~isempty(ind) && ~any(ind==0)
                    seg = this.myLaneGroup.midline(ind);
                    rpos = pos - cum_length(ind);
                    v.draw(seg.start_p + rpos * seg.d , seg.d, this.myLaneGroup.vehicle_length, this.myLaneGroup.vehicle_width);
                else
                    break
                end
                
                % advance position
                pos = pos - step;
            end
            
        end
        
    end
    
end

