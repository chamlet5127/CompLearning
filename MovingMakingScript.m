% % close all
% % clear all
% % clc

%%%%%%%%%%%% Video Writing
% For information on how to customize the template here see: 
% You will probably want to at the very least adjust your frame rate
% https://www.mathworks.com/help/matlab/ref/videowriter.html
% define your video file and open it
vidObj = VideoWriter('testfile.avi')
open(vidObj)
%%%%%%%%%%%% Video Writing

%Meshgrid settings for box
xmin=-3;
xspacing=0.65;
xmax=3;
ymin=-3;
yspacing=0.315;
ymax=3;
xbox = xmin:xspacing:xmax;
ybox = ymin:yspacing:ymax;
l=length(xbox);
m=length(ybox);
[Xpart,Ypart]=meshgrid(xbox,ybox);
Xpart=reshape(Xpart,l*m,1);
Ypart=reshape(Ypart,l*m,1);
gridsize=size(Xpart);
particles=l*m;
brinevelocity=0.2;
Xnewpart=[];
Ynewpart=[];
numtentacles = 9;
Xe = 2.1584;
Ye = 1.295.* ones(1,numtentacles);
Xb = .955;
feedprobability=1;

% % % % % Tentacle base and endpoints
[base, endpoints, points]= tentaclepoints (Xe,Ye,Xb,numtentacles);
counter = zeros(size(endpoints));

% % % % % Creates an empty matrix for the (X,Y) points all along the
% tentacles, including the base and endpoints
X=zeros(10, size(endpoints,2));
Y=zeros(10, size(endpoints,2));

% % % % % Points that define tentacle location. Matrix reads (:1)= X
% basepoints; (:2)= Y basepoints; (:3)= X endpoints; (:4)= Y endpoints
M = points';

% % % % % Equidistant points on each tentacle
for c = 1:numtentacles
    [X(:,c),Y(:,c)] = tentaclelinepts(M,c);
end

% % % Timesteps
k=0;
while length(Xpart)>100
%for k=1:100
    % % % % % Random particles in a box
    [Xpart,Ypart]=brineshrimprandomization(brinevelocity,Xpart,Ypart,xmin,xmax,ymin,ymax,m);
    plot(Xpart,Ypart,'*');
    axis([-3 3 -3 3])
    hold on
    % % % Runs through number of tentacles
    for j=1:numtentacles
        % % % Tentacle threshold
        if counter(j)>25
            counter(j)=0;
            % % % Adds 1 for every timestep the tentacle is "out" until
            % it reaches threshold
        elseif counter(j)>0
            counter(j)=counter(j)+1;
        else
            % % %Runs through each particle
            for s=1:length(Xpart)
                particlex=Xpart(s);
                particley=Ypart(s);
                % % % Checks 1 particle against all 10 tentacle points
                % distanes
                distances=sqrt((particlex-X(:,j)).^2+(particley-Y(:,j)).^2);
                
                % % % Adds (particlex,particley) to (Xnewpart,Ynewpart) if
                % it is at least a radius of 0.07 away
                if distances(1:end)>.07
                    Xnewpart(length(Xnewpart)+1,1) = particlex;
                    Ynewpart(length(Ynewpart)+1,1) = particley;
                else
                    % % % If (particlex,particley) are within a 0.07
                    % radius, then it adds the s+1 term to the end of (Xnewpart,Ynewpart)
                    randomprobability=rand();
                    if randomprobability<feedprobability
                        counter(j)=counter(j)+1;
                        Xnewpart(s:length(Xpart)-1,1)=Xpart(s+1:end);
                        Ynewpart(s:length(Ypart)-1,1)=Ypart(s+1:end);
                        feedprobability=0.1;
                        break
                    else
                    Xnewpart(length(Xnewpart)+1,1) = particlex;
                    Ynewpart(length(Ynewpart)+1,1) = particley;
                    end
                end
            end
            % % % Redefines (Xnewpart,Ynewpart) based on how many particles
            % were outside of the specified radius
            Xpart = Xnewpart;
            Ypart = Ynewpart;
            % % % Clears (Xnewpart,Ynewpart) before it starts checking next
            % tentacle
            Xnewpart(:,:)=[];
            Ynewpart(:,:)=[];
        end
    end
    
    for j=1:numtentacles
        if counter(j)>0
        else
            % % % Line plot
            plot([base(j) endpoints(j)],[0 1.295],'k')
            % % % Actual tentacle plot
            plot (X(:,j),Y(:,j),'sr')
            xlim([-3 3])
            ylim([-3 3])
        end
    end
    if feedprobability<0.99999
        feedprobability=feedprobability+0.1;
    end
    
    %%%%%%%%%%%% Video Writing
    % Save the current frame
    currFrame = getframe(gcf);
    % Add the current frame to your video file
    writeVideo(vidObj,currFrame);
    %%%%%%%%%%%% Video Writing
    
    hold off
    k=k+1;
    pause (.1)
end
%%%%%%%%%%%% Video Writing
% Close the file
close(vidObj)
%%%%%%%%%%%% Video Writing