classdef Event < handle

    properties(Access=public)
        time
    end

    methods

        function this = Event(time)
            this.time = time;
        end
        
    end

end

