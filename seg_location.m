%example_global
%depth = dm.current_dispmap();
clear;
load('depth.mat');%depth_map
depth = depth_map;
index = imread('index2.png');%segmentation
index = imresize(index,[size(depth,1),size(depth,2)]);
depth_edge = edge(depth,'canny');
%for example car
%car 64,0,128
%building 128,0,0
car = get_area(index,64,0,128);
%if there are many cars
car = logical(car);
L = bwlabel(car);
num = max(L(:));
%each car has a label
final_result = zeros(size(depth));
for i = 1:num
    [x,y]=find(L==i);
    if numel(x)<2000%area
        continue;
    end
    obj_only = zeros(size(car));
    depth_data = zeros(numel(x),1);
    for j = 1:numel(x)
        obj_only(x(j),y(j)) = 255;
        depth_data(j) = depth(x(j),y(j));
    end
    index_edge = edge(obj_only,'canny');
    score = get_up_edge(index_edge,depth_edge,30);%threshhold = 20
    %if score > 1, this object is the target
    mean_depth = mean(depth_data);
    %if mean_depth < depth_threshold 
    if score
        final_result = final_result + obj_only;
    end
        
end
imshow(final_result);