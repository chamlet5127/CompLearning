 
% This is an example script that will plot a curve of f(v) for particular
% values of g,k, and m. I chose an 'easy' equilibrium point so that I could
% show an example with a nice clean zero, but you can change g,k,and m and
% plot other curves.

% Also in this script I have given demos of how to do various things with
% plots so that you can make nice clean plots for the class (and in other
% classes or projects). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% None of the next three lines are strictly necessary, and you should use with caution
% (if you have things open or variables defined you will lose them all and
% basically start with a blank slate)

clear all                                    % This clears all variables defined in your MatLAB session
close all                                    % This closes all figures
clc                                          % This clears your display

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The next two lines will set the default size for your tick marks on your
% axes, and for your axis labels, titles, legends, etc. These will be the
% default for ALL plots until you close MatLAB completely and reopen it.
% You only have to run a default setting once in a MatLAB session, but I often add it to a
% script so I don't have to remember.

set(0,'DefaultAxesFontSize', 18)           
set(0,'DefaultTextFontSize', 18)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End Set up, Begin Example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Defining your parameters and variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Define your physical parameters

g = 10;            % gravitational constant
k = 10;            % drag coefficient
m = 100;            % mass of the object

v = -20:0.1:20;     % When plotting f(v),   
                    %v is the independent variable, so we define a region of values for v

foo = @(v) -g-k.*v.*abs(v)./m;  % This is an example of an inline function
% <functionname> = @(inputvariable) <define function>

% In this case you could also just do something like 

% RHS = -g-k.*v.*abs(v)./m;   

% And get the same thing. You might try commenting out line 58 and
% uncommenting line 53 and see you get the same graph. 

RHS=foo(v);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End definitions and calculation, begin plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up the plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Often the key to a good plot is making it look nice, so you have to do a
% lot more than just plot a line. You want to make your plots looks a
% clear and readable as possible. Label things and don't make people guess!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(1)     % You can just us plot and Matlab will open a new figure window, but you can also specify 
              % a figure number. This is can be used to start a new blank figure or go back to an existing
              % figure and add to it or clear it
              
line([0 0],[-20 20],'LineWidth',3,'Color','k')      % This draws a dark black line for the vertical axis

grid on                                             % This turns on a grid to remove type 'grid off'

hold on                                             % This holds the graph so that new plots don't overwrite
                                                    % The default is 'hold off' which will delete previous plots
                                                    % and overwrite them with the new one.
                                                 
line([-20 20],[0 0],'LineWidth',3,'Color','k')     % This draws a dark black line for the horizontal axis
% I used linewidth to make it thick and 'k' to force it to be black.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Actually plotting the function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is your actual problem (as you can see most of this is making things
% look pretty for other humans!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(v,RHS','LineWidth',4);                         % This plots v vs. f(v)
% I didn't set a color here, matlab will cycle through various colors
% Some you can set with letters are y,m,k,g,b,r,c. For other colors you can
% see the help document.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Putting on labels and making things clear)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The command below plots a big red dot with a thin black border at the point
% where my equilibrium point is
plot(-sqrt(m*g/k),0,'o','MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
% I used 'o' to set a circle. Other common choices are s,d,*. See the plot help
% document for more options.

% This sets my display window boundaries
axis([-20 20 -20 20])  

% Label the v and f(v) axes with an even bigger font (and bold) than the
% default
ylabel('f(v)','FontSize',20,'FontWeight','bold')  
xlabel('v','FontSize',20,'FontWeight','bold')

%Give the plot (an even bigger) title
title('Equilibrium Point','FontSize',24)

% The code below will put text where my equilibrium point is. 
x1 = -sqrt(m*g/k);          %  horizontal coordinate
y1 = 0;                     %  vertical coordinate
str2 = ['(',num2str(x1),',',num2str(y1),') Equilibrium Point'] % The label
text(x1,y1+0.4,str2) 
% This tells matlab where to start printing and then what to print. Note
% that you may need to play with this depending on your screen resolution
% and figure window size.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Note that much of matlab defines plots with builtin objects that say 'x' and 'y'
% something. So it's pretty common to see code using x,y variables and
% commands even if YOUR variables and functions are something like v or t
% or q or whatever. For example, if you want to change the label on the horizontal
% axis you have to call it 'xlabel' regardless of what your variable name is. 
% So be careful of that until you get used to it. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This will first read in the size of your screen into "screen_size" as
% pixel number values
screen_size = get(0, 'ScreenSize');

% and then you can set the size of your graph.
set(1, 'Position', [0 0 0.75*screen_size(3) 0.75*screen_size(4) ] );
% the syntax is set(<figure number>,'Position', [ startx starty endx endy]);
% So in my case the code will set my figure 1 to start at the bottom left
% edge of my screen and size its width and height to be 75% of my screen's
% width and 75% of my screen's height.
export_fig('multi','-pdf','-nocrop')