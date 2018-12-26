function [out]=test_up_edge(index_edge,depth_edge,index,thres)
    %应是孤立的连通域
    [~,y]=find(index_edge);
    idmin = min(y);
    idmax = max(y);
    length = idmax - idmin + 1;
    score = 0;
    for j = idmin : idmax
        lie = index_edge(:,j);
        [id,~] = find(lie);
        upi = min(id);
        if(index(upi + 1,j) == 0)%it is not up side
            length = length - 1;
            continue;
        end
        down = min(upi - thres,size(depth_edge,1));
        up = max(upi+thres,0);
        candi_area = depth_edge(down:up,j);
        if(~isempty(find(candi_area,1)))
            score = score + 1;
        end
    end
    out = 0;
    if(score/length > 0.85)
        out = 1;
    end
    length
    score
       
        
end

    
