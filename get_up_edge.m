function [out]=get_up_edge(edge,depth_edge,thres)
    %应是孤立的连通域
    [x,y]=find(edge);
    idmin = min(y);
    idmax = max(y);
    length = idmax - idmin + 1;
    score = 0;
    for j = idmin : idmax
        lie = edge(:,j);
        [id,~] = find(lie);
        upi = min(id);
        down = min(upi - thres,size(depth_edge,1));
        up = max(upi+thres,0);
        candi_area = depth_edge(j,down:up);
        if(size(find(candi_area),1) > 0)
            score = score + 1;
        end
    end
    out = 0;
    if(score/length > 0.6*length)
        out = 1;
    end
            
       
        
end

    
