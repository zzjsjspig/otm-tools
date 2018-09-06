classdef SignalEvent < Event
    
    properties
        signal
        phase
        color
    end
    
    methods
        
        function this = SignalEvent(time,signal,items)
            this = this@Event(time);
            if nargin<2
                return
            end
            this.signal = signal;
            this.phase = uint32(str2double(items{1}));
            this.color = items{2};
        end
        
        function [] = process(this)
            disp('a')
        end
        
        
    end
    
end

