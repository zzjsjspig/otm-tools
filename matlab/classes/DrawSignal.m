classdef DrawSignal
    
    properties
        phases % map from phase id (long) to patch
        
    end
    
    methods
        
        function this = DrawSignal(beats,java_signal)
                        
            % initialize map from lanegroup to number of signal patches
            lg2numpatch = containers.Map('KeyType','uint32','ValueType','double');
            lgids = beats.laneGroupMap.keys;
            for i=1:numel(lgids)
                lg2numpatch(lgids{i}) = 0;
            end
            
            for i=1:java_signal.signal_phases.size()
                phase = java_signal.signal_phases.get(i-1);
                
                % gather all lane groups signalized by this phase
                lgs = [];
                for j=1:numel(phase.road_connections)
                    rcid = phase.road_connections.get(j-1);
                    mylgs = beats.api.get_in_lanegroups_for_road_connection(rcid);
                    for k=1:numel(mylgs)
                        lgs = [lgs mylgs.get(k-1)];
                    end
                end
                
                lgs = unique(lgs);
                
                % gather end points of the lanegroups
                L = 3;
                offset = 1;
                patches = [];
                for j=1:numel(lgs)
                    lg = beats.laneGroupMap(lgs(j));
                    midline = lg.midline;
                    numpatch = lg2numpatch(lgs(j));
                    s = midline.end_p  + midline.d*(offset + numpatch*L);
                    a1 = s + midline.n_end * lg.lanegroup_width/2;
                    a2 = s - midline.n_end * lg.lanegroup_width/2;
                    a3 = a2 + L*midline.d;
                    a4 = a1 + L*midline.d;
                    p = [a1;a2;a3;a4];
                    patches(j) = patch('XData',p(:,1),'YData',p(:,2),'FaceColor',[0 1 0]);
                    lg2numpatch(lgs(j)) = numpatch+1;
                end
                
                this.phases(phase.id) = patches;

            end
            
            
            
        end
        
        function this = set_phase_color(this,phase_id,color)
            switch color
                case 'DARK'
                    c = [0 0 0];
                case 'GREEN'
                    c = [0 1 0];
                case 'YELLOW'
                    c = [1 1 0];
                case 'RED'
                    c = [1 0 0];
                otherwise
                    error('>>>')
            end
            set(this.phases(phase_id),'FaceColor',c)
        end
        
    end
    
end

