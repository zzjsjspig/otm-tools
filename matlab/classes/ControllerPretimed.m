classdef ControllerPretimed < handle
    
    properties(Access=public)
        controller
    end
    
    properties(Access=private)
        X % structures
    end
    
    methods(Access = public)
        
        function this = ControllerPretimed(id,actuator_id)
            this.X = ScenarioBuilder.build_structs;
            this.controller = this.X.controller_struct;
            this.controller.ATTRIBUTE.id = id;
            this.controller.target_actuators.ATTRIBUTE.ids = actuator_id;
        end

        function this = add_schedule_item(this,start_time,cycle,offset,stages)
            si = this.X.scheduleitem_struct;
            si.ATTRIBUTE.start_time = start_time;
            si.ATTRIBUTE.cycle = cycle;
            si.ATTRIBUTE.offset = offset;
            si.stages.stage = repmat(this.X.stage_struct,1,numel(stages));
            for i=1:numel(stages)
                si.stages.stage(i).ATTRIBUTE.order = i;
                si.stages.stage(i).ATTRIBUTE.phases = writecommaformat(stages(i).phases,'%d',',');
                si.stages.stage(i).ATTRIBUTE.duration = stages(i).duration;
            end
            this.controller.schedule.schedule_item(end+1) = si;
        end
        
    end
    
end

