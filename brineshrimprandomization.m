function [Xpart,Ypart] = brineshrimprandomization(brinevelocity,Xpart,Ypart,xmin,xmax,ymin,ymax,m)
%brineshrimprandomization 

% Creates randomly placed particles within a 2d meshgrid. Accounts for
% points being created outside of the range by pushing them to the opposite
% side. 
for i=1:size(Xpart)
    for j=1:m
        for a=-brinevelocity
            b=brinevelocity;
            r1=a+(b-a)*rand(1,1);
        end
        for a=-brinevelocity
            b=brinevelocity;
            r2=a+(b-a)*rand(1,1);
        end
        Xpart(i)=Xpart(i)+r1;
        Ypart(i)=Ypart(i)+r2;
        if Xpart(i)>xmax
            Xpart(i) = Xpart(i)-xmax+xmin;
        elseif Xpart(i)<xmin
            Xpart(i) = Xpart(i)-xmin+xmax;
        end
        if Ypart(i)>ymax
            Ypart(i) = Ypart(i)-ymax+ymin;
        elseif Ypart(i)<ymin
            Ypart(i) =  Ypart(i)-ymin+ymax;
        end
    end
end
end

