function [base, endpoints, points] = tentaclepoints(Xe,Ye,Xb,s)
%Plots tentacle endpoints 
%Xe is x endpoints 
%Yb is y basepoints  
%Xb is x basepoints 
%s is number of tentacles or spacing 
endpoints = linspace(-Xe,Xe,s);
base = linspace(-Xb,Xb,s);
sz = size(base);
Yb = zeros(sz); 

% plot (endpoints,Ye,'.c','MarkerSize',15)
% hold on
% plot (base,Yb,'.c','MarkerSize',15)
%  hold on
points = [base; Yb; endpoints; Ye];
 return 
end

