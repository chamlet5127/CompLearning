close all

xmin=-10;
xspacing=1;
xmax=10;
ymin=-10;
yspacing=1;
ymax=10;
% Meshgrid settings for box
x = xmin:xspacing:xmax;
y = ymin:yspacing:ymax;
[X,Y] =meshgrid(x,y);
[m,n]=size(X);
X=reshape(X,m*n,1);
Y=reshape(Y,m*n,1);
particles=m*n;
% Brine shrimp in box
tentacles=20;
brinevelocity=0.2;
Xt=[-2.1584 -1.9555 -1.752 -1.549 -1.346 -1.143 -.9395 -.7363 -.5332 -.33 .33 0.5332 0.7363 0.9395 1.143 1.346 1.549 1.752 1.9555 2.1584];
% Xt=[-.33];
% Yt=[1.295];
% T=[-.05079];
Yt=[1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295 1.295];
T=[-.955 -.8634 -.7618 -.6603 -.5587 -.4571 -.3555 -.2539 -.1524 -.05079 .05079 .1524 .2539 .3555 .4571 .5587 .6603 .7618 .8634 .955];
% p=.965;
% T=linspace(-p,p,20);
% Xt and Yt are the tentacle endpoints
t=0;
counter=zeros(size(Xt));
plotT=T;



vertex_fid = fopen ('particles.vertex', 'w');
% while particles>439
% for k=1:450
    for i=1:particles 
        for j=1:n
            for a=-brinevelocity
                b=brinevelocity;
                r1=a+(b-a)*rand(1,1);
            end
            for a=-brinevelocity
                b=brinevelocity;
                r2=a+(b-a)*rand(1,1);
            end
            X(i)=X(i)+r1;
            Y(i)=Y(i)+r2;
            fprintf (vertex_fid,'%1.16e %1.16e\n', X(i), Y(i)); 
            if X(i)>xmax
                X(i) = X(i)-xmax+xmin;
                fprintf (vertex_fid,'%1.16e %1.16e\n', X(i), Y(i));
            elseif X(i)<xmin
                X(i) = X(i)-xmin+xmax;
                fprintf (vertex_fid,'%1.16e %1.16e\n', X(i), Y(i));
            end
            if Y(i)>ymax
                Y(i) = Y(i)-ymax+ymin;
                fprintf (vertex_fid,'%1.16e %1.16e\n', X(i), Y(i));
            elseif Y(i)<ymin
                Y(i) =  Y(i)-ymin+ymax;
                fprintf (vertex_fid,'%1.16e %1.16e\n', X(i), Y(i));
            end
        end 
        
    end
    fclose (vertex_fid);
   
% % % % % %     Randomization of Brine Shrimp 

    for j=1:tentacles 
        if counter(j)>25
           counter(j)=0; 
        elseif counter(j)>0
            counter(j)=counter(j)+1; 
        else
            for i=1:particles
                if sqrt((Xt(j)-X(i)).^2+(Yt(j)-Y(i)).^2)<.07
                    X=[X(1:i-1);X(i+1:end)];
                    Y=[Y(1:i-1);Y(i+1:end)];
                    counter(j)=counter(j)+1;
                    particles=length(X);
                    break
                end
            end 
        end 
    end 
          
%     Tentacles come into contact w/ brine shrimp
     
    vertex_fid = fopen ('tentacles.vertex', 'w'); 
    
    for j=1:tentacles
        if counter(j)>0
        else
        plot([T(j) Xt(j)],[0 Yt(j)],'k')
        fprintf(vertex_fid, '%1.16e %1.16e\n', Xt(j), Yt(j));
        end
    end
    
    fclose (vertex_fid);
    
    clear all
    
    
    A = dlmread('particles.vertex');
    plot (A(:,1),A(:,2),'*')
    hold on
    B = dlmread('tentacles.vertex');
    plot (B(:,1),B(:,2),'*')