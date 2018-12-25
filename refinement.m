%clear;
%index = imread('/home/z/index_t.png');
%index = index_t;
load('index_t.mat');
index = index_t;
%depth = load('/home/z/depth.mat');
edge_index_t = edge(index_t,'canny');
load('depth.mat');
depth = depth_map;


edge_depth = edge(depth,'canny');
%load('edge_yasil');
edge_depth(319:456,266:616) = edge_yasil;
[x,y] = find(index);
for i = 1: size(x)
    data(i) = depth(x(i),y(i));
end
%wrong data range
q_= prctile(data,[25,75]);
p25=q_(1,1);
p75=q_(1,2);
upper = p75+ 1.5*(p75-p25);
%upper = 1;
lower = p25-1.5*(p75-p25);
[tx,ty] = find(test_bw);

%mean data
%iii=find(data>lower & data <upper);
m_data = mean(data);
for i = 1:size(tx)
    depth(tx(i)+319,ty(i)+266) = m_data;
end
%edge = edge(index,'canny');
edge1 = edge_index_t;
edge_r = edge1;

[x,y] = find(edge1);
thres = 30;
min_thres = 3;
for k = 1 : size(x)
    x_ = x(k);
    y_ = y(k);
    [x_f,y_f,flag] = edge_refine(x_,y_,depth,edge_depth,thres,min_thres,upper,lower,m_data);
    if(depth(x_,y_)<lower || depth(x_,y_)>upper||flag == 1)
        edge_r(x_,y_) = 0;
        edge_r(x_f,y_f) = 1;
    end
    %such pixel can be refined
%     if(depth(x_,y_)<lower || depth(x_,y_)>upper || edge_around(x_,y_,edge_depth,thres,min_thres) )
%         [x_f,y_f] = refine(x_,y_,25,depth,upper,lower);
%         edge_refine(x_,y_) = 0;
%         edge_refine(x_f,y_f) = 1;
%     end
end
figure(5),imshow(edge_r);