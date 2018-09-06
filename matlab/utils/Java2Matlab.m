function [ M ] = Java2Matlab( J )
% Convert Java collections to matlab matrices

switch class(J)
    
    case 'java.util.ArrayList'
        M = nan(1,J.size());
        for i=1:J.size()
            M(i) = J.get(i-1);
        end
        
    otherwise
        error('unsupported class')
        
end
