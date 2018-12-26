function flag = test_guide(index_edge,index)
    
    flag = 1; %up 1   side 2
    [x,y] = find(index_edge);
    id_x_min = min(x);
    id_x_max = max(x);
    length_x = id_x_max - id_x_min + 1;%left and right
    
    id_y_min = min(y);
    id_y_max = max(y);
    length_y = id_y_max - id_y_min + 1;%up
    max_ = 0;min_ = size(index_edge,1);
    max2 = 0;min2 = size(index_edge,2);
    for j = id_y_min : id_y_max
        lie = index_edge(:,j);
        [id,~] = find(lie);
        upi = min(id);
        if(index(upi + 1,j) == 0)%it is not upside
            length_y = length_y - 1;
            continue;
        end
        if(upi > max_)
            max_ = upi;
        end
        if(upi < min_)
            min_ = upi;
        end
    end
    max_gap(1) = max_ - min_;
    max_ = 0;min_ = size(index_edge,2);
    for j = id_x_min : id_x_max
        hang = index_edge(j,:);
        [~,id] = find(hang);
        lefti = min(id);
        righti = max(id);
        if(lefti > max_)
            max_ = lefti;
        end
        if(lefti < min_)
            min_ = lefti;
        end
        if(righti > max2)
            max2 = righti;
        end
        if(righti < min2)
            min2 = righti;
        end
    end
    max_gap(2) = max_ - min_;
    max_gap(3) = max2 - min2;
    [~,flag2] = max(max_gap);

    
    if(length_x > 2*length_y &&flag2 > 1)  %当侧边比上沿长很多，并且变化幅度比上沿小
        flag = 2;
    end
end
            
