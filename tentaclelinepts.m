function [X,Y] = tentaclelinepts(M,c)
% % % % % Points on the tentacle 
x0 = M(c,1);
y0 = M(c,2);
x1 = M(c,3);
y1 = M(c,4);
r0 = [x0,y0];
r1 = [x1,y1]; 
v = [(x1-x0),(y1-y0)];

% Number of equidistant points on tentacle 
t = linspace(0,1,10);
% Creates the equidistant points on tentacle
X = x0 + t*(x1-x0);
Y = y0 + t*(y1-y0);
% plot (X,Y,'sr');
% hold on 
end

