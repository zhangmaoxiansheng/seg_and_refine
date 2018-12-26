function [out]=test_side_edge(index_edge,depth_edge,thres)
    %应是孤立的连通域
    [x,~]=find(index_edge);
    idmin = min(x);
    idmax = max(x);
    length = idmax - idmin + 1;
    l_score = 0;
    r_score = 0;
    %left side
    for j = idmin : idmax
        hang = index_edge(j,:);
        [~,id] = find(hang);
        lefti = min(id);
        left_s = max(0,lefti-thres);
        left_l = min(lefti+thres,size(index_edge,2));
        candi_area = depth_edge(j,left_s:left_l);
        if(~isempty(find(candi_area,1)))
            l_score = l_score + 1;
        end
        righti = max(id);
        right_s = max(0,righti-thres);
        right_l = min(righti+thres,size(index_edge,2));
        candi_area2 = depth_edge(j,right_s:right_l);
        if(~isempty(find(candi_area2,1)))
            r_score = r_score + 1;
        end
    end
    out = 0;
    
    if(l_score/length > 0.6 || r_score/length > 0.6)
        out = 1;
    end
            
       
        
end