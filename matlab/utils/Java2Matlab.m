function [ M ] = Java2Matlab( J )
% Convert Java collections to matlab matrices

switch class(J)
    
    case 'java.util.ArrayList'
        M = nan(1,J.size());
        for i=1:J.size()
            M(i) = J.get(i-1);
        end
       
    case 'java.util.HashSet'
        M = nan(1,J.size());
        it = J.iterator;
        i=1;
        while it.hasNext()
            M(i) = it.next();
            i = i+1;
        end
        
    case 'java.util.HashMap'
        entries = J.entrySet.toArray;
        M = containers.Map('KeyType','double','ValueType','any');
        for i=1:numel(entries)
            M(entries(i).getKey) = entries(i).getValue;
        end

    otherwise
        error('unsupported class')
        
end
