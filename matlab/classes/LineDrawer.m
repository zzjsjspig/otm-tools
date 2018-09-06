classdef LineDrawer
    
    properties
    end
    
    methods(Access=public,Static)    
        
        function [h]=plot_line_for_points(segments,offset,start_at_percentage,end_at_percentage,width,color)
            
            if numel(unique(color))~=1
                error('numel(unique(color))~=1')
            end
            
            total_length = sum([segments.length]);
            cum_length = cumsum([segments.length]);
            start_at = total_length*start_at_percentage;
            end_at   = total_length*end_at_percentage;
            
            start_segment = find(start_at<=cum_length,1,'first');
            end_segment = find(end_at<=cum_length,1,'first');
            if isempty(end_segment)
                end_segment=numel(segments);
            end
            
            if start_segment>1
                draw_start = start_at - cum_length(start_segment-1);
            else
                draw_start = start_at;
            end
            remains = end_at-start_at;
            
            h = [];
            for ii=start_segment:end_segment
                
                seg = segments(ii);
                
                draw_length = min([remains segments(ii).length-draw_start]);
                
                % start points
                P = seg.start_p + seg.d * draw_start;
                nP = LineDrawer.interpolate_normal(seg.n_start,seg.n_end,draw_start,seg.length);
                d = LineDrawer.distance_to_offset(seg.d,nP,offset);
                a1 = P + nP*d;
                a2 = P + nP*(d+width);
                
                % end points
                P = P + seg.d * draw_length;
                nP = LineDrawer.interpolate_normal(seg.n_start,seg.n_end,draw_start+draw_length,seg.length);
                d = LineDrawer.distance_to_offset(seg.d,nP,offset);
                a3 = P + nP*(d+width);
                a4 = P + nP*d;
                
                % patch
                p = [a1;a2;a3;a4];
                h(end+1) = patch('XData',p(:,1),'YData',p(:,2));
                
                hold on
                
                remains = remains - draw_length;
                draw_start = 0;
                
                if remains<1e-4
                    break
                end
                
            end
            
            set(h,'FaceColor',LineDrawer.get_color(color(1)));
            set(h,'EdgeAlpha',0)
        end
                
    end
    
    methods(Access=private,Static)
        
        function z = distance_to_offset(d,n,offset)
            s = abs(sum(d.*n));
            if s==1
                error('bad')
            end
            z = offset/sqrt(1-s^2);
        end
        
        function nx = interpolate_normal(no,ne,l,L)
            nx = no + (l/L)*(ne-no);
        end
        
        
        function [C] = get_color(c)
            switch c
                case 0
                    C = [0 0 0];
                case 1
                    C = 0.7*[1 1 1];
                otherwise
                    error('unknown color')
            end
        end
        
    end
    
end

