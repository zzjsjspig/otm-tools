function [h]=textpos(dx,dy,ang,str,s,ax)
% [h]=textpos(dx,dy,ang,str,s)
% dx=x position
% dy = y position
% a = angle
% s = FontSize

if(nargin>5)
    set(gcf,'CurrentAxes',ax)
else
    a = get(gcf,'Children');
    if(~isempty(a))
        axes(a(1));
    else
        axes
    end
end
a=axis;
h=text(a(1) + dx*(a(2)-a(1)),a(3) + dy*(a(4)-a(3)),str);
set(h,'FontSize',s)
set(h,'FontWeight','bold')
set(h,'Rotation',ang)
set(h,'BackgroundColor',[0.85 0.85 0.85])

