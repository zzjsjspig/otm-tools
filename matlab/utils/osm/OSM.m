classdef OSM
    
    properties
        filename
        nodes
        routes
    end
    
    methods
        
        function [this] = OSM(filename)
            this.filename = filename;
            parsed_osm = parse_openstreetmap(filename);
            
            this.nodes = repmat(struct('id',nan,'x',nan,'y',nan),1,length(parsed_osm.node.id));
            for i=1:length(parsed_osm.node.id)
                this.nodes(i).id = parsed_osm.node.id(i);
                this.nodes(i).x = parsed_osm.node.xy(1,i);
                this.nodes(i).y = parsed_osm.node.xy(2,i);
            end
            
            this.routes = repmat(struct('id',nan,'nodes',[]),1,length(parsed_osm.way.id));
            for i=1:length(parsed_osm.way.id)
                this.routes(i).id = parsed_osm.way.id(i);
                this.routes(i).nodes = parsed_osm.way.nd{i};
            end
            
            % remove isolated nodes
            this.nodes( ~ismember([this.nodes.id],unique([this.routes.nodes]) ) ) = [];

        end

        function [] = plot_all(this)
            

            figure
            plot([this.nodes.x],[this.nodes.y],'.');
            hold on
            
            for i=1:length(this.routes)
                node_ind = index_into(this.routes(i).nodes,[this.nodes.id]);
                x = [this.nodes(node_ind).x];
                y = [this.nodes(node_ind).y];
                plot(x,y,'-','Color',rand(1,3))                
            end
            
        end
        
        
    end
    
end

