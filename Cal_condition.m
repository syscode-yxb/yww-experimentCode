function [ relation ] = Cal_condition( data,radius )

relation = pdist2(data,data);

relation=relation<=radius;

end