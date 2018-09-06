classdef Vehicle < handle
    
    properties
        id
        myPatch
    end
    
    methods(Access=public)
        
        function [this] = Vehicle(id)
            if nargin==0
                return
            end
            this.id = id;
            
            this.myPatch = patch('Visible','off');
            this.myPatch.FaceColor = 0.5+0.5*rand(1,3);
            
        end

        % x and y are the coordinates of the middle of the rear edge of the
        % vehicle. d is a unit vector along the length of the vehicle
        function []=draw(this,p,d,length,width)
            
            n = cross([d 0],[0 0 1]);
            n = n(1:2);
         
            a1 = p + n * width/2;
            a2 = p - n * width/2;
            a3 = a2 + d * length;
            a4 = a1 + d * length;
            
            p = [a1;a2;a3;a4];

            this.myPatch.XData = p(:,1);
            this.myPatch.YData = p(:,2);
            this.myPatch.Visible = 'on';
            
        end
        
    end
    
%     methods(Access=public,Static)
%         
%         function [length,width]=dimensions()
%             length = 3;
%             width = 2.5;
%         end
%         
%     end
    
end

