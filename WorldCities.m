%**
% *
% * @author Sara Chahardoli
% 
%% Notes
%  all these parts bellow are written for the first 400 cities
%  since it will take too long for all of the 15493 cities
%% OVERALL
fid = fopen('worldcities-short.xlsx','r') ;
T = readtable("worldcities-short.xlsx",...
    "sheet","1");
f = @(lat1,lat2,lng1,lng2) acos(sin(lat1)*...
    sin(lat2)+cos(lat1)*cos(lat2)*cos(abs(lng1-lng2))) ;
r = 6371 ; %km
lng = deg2rad(T.lng);
lat = deg2rad(T.lat);
n = 400 ; % 15493
c = cell(n+1,n+1) ; %15494
c(:,:) = {' '} ;
c(1,2:end) = T.city_name(1:n) ;
c(2:end,1) = T.city_name(1:n) ;
for i = 2:n+1
    for j = 2:n+1
        
        d = r*f(lat(i-1),lat(j-1),...
            lng(i-1),lng(j-1)) ;
        c(i,j) = {d} ;
        if(c{i,j}<0.001)
            c(i,j) = {0} ;
        end
    end
end
writecell(c,"worldcities.xlsx");
fclose(fid) ;

%% PART 1
[i, ~] = find(strcmp(c, 'Tehran')) ; % finding which row is for Tehran
s = c(i(1),2:end) ; % extracting the row of Tehran coordinates
C = cell2mat(s) ;
[maxC, imax] = max(C) ;
disp("farthest city from Tehran is:");
disp(T.city_name(imax));
disp("closest city to Tehran is:");
[~, imin] = min(C) ;
C(imin) = []; % to make sure Tehran is not included
[minC, imin] = min(C) ;
disp(T.city_name(imin));
%% PART 2
disp("cities bellow are less than 20,000 km apart from Tehran:") ;
disp(T.city_name(find(C<20000)));
%% PART 3-1: Japan
Countries = T.country(1:n);
[j, ~] = find(strcmp(Countries, 'Japan')) ;
[distance,jmin] = min(C(j));
disp("The nearest city in Japan to Tehran is:") ;
disp(T.city_name(j(jmin)));
disp("which is:") ;
disp(distance) ;
disp("kilometers apart.") ;
%% PART 3-2: Iraq
[ir, ~] = find(strcmp(Countries, 'Iraq')) ;
[distance,irmin] = min(C(ir));
disp("The nearest city in Iraq to Tehran is:") ;
disp(T.city_name(ir(irmin)));
disp("which is:") ;
disp(distance) ;
disp("kilometers apart.") ;
%% PART 3-3: Turkey
[t, ~] = find(strcmp(Countries, 'Turkey')) ;
[distance,tmin] = min(C(t));
disp("The nearest city in Turkey to Tehran is:") ;
disp(T.city_name(t(tmin)));
disp("which is:") ;
disp(distance) ;
disp("kilometers apart.") ;
%% PART 3
[iq, ~] = find(strcmp(Countries, 'Iraq')) ;
[in, ~] = find(strcmp(Countries, 'Iran')) ;
x = length(in) ;
y = length(iq) ;
distance = cell(x,y);
for i = 1:x
    for j = 1:y
        distance(i,j) = c(iq(j)+1,in(i)+1) ;
    end
end
dis = cell2mat(distance) ;
minval = min(dis,[],'all') ;
for i = 1:x
    for j = 1:y
        if dis(i,j) == minval
            I = i ;
            J = j ;
        end
    end
end
disp("These two cities from Iraq and Iran are the nearest") ;
disp(T.city_name(iq(J))) ;
disp(T.city_name(in(I))) ;
disp("by") ;
disp(minval) ;
disp("kilometers.") ;
%% PART 3
[tur, ~] = find(strcmp(Countries, 'Turkey')) ;
[in, ~] = find(strcmp(Countries, 'Iran')) ;
x = length(in) ;
y = length(tur) ;
distance = cell(x,y);
for i = 1:x
    for j = 1:y
        distance(i,j) = c(tur(j)+1,in(i)+1) ;
    end
end
dis = cell2mat(distance) ;
minval = min(dis,[],'all') ;
for i = 1:x
    for j = 1:y
        if dis(i,j) == minval
            I = i ;
            J = j ;
        end
    end
end
disp("These two cities from Turkey and Iran are the nearest") ;
disp(T.city_name(tur(J))) ;
disp(T.city_name(in(I))) ;
disp("by") ;
disp(minval) ;
disp("kilometers.") ;
