function [x_f,y_f,flag] = edge_refine(x,y,depth_map,edge_depth,thres,min_thres,upper,lower,mean)
    flag = 0;
    x_f = x;
    y_f = y;
    up = x - thres;
    down = x + thres;
    right = y + thres;
    left = y - thres;
    vec_r = depth_map(x,y:right);
    vec_l = depth_map(x,left:y);
    vec_u = depth_map(up:x,y);
    vec_d = depth_map(x:down,y);
    edge_r = edge_depth(x,y:right);
    edge_l = edge_depth(x,left:y);
    edge_u = edge_depth(up:x,y);
    edge_d = edge_depth(x:down,y);
    %edge_r(1)
    gre_r_max = 0;gre_l_max = 0;gre_d_max = 0;gre_u_max = 0;
    gre_max = 0;
    mean_disp = 100;
    direction=0;
    d_id = 0;
    edge_find_count = 0;
    
    edge_pix = 0;
    id_pix = 0;
    for i = 1 : thres
        %gre and get the max at the same time
        depth_gre_r(i) = abs(vec_r(i+1) - vec_r(i));
        if(vec_r(i) < upper && vec_r(i) > lower && depth_gre_r(i) > gre_max)
            gre_max = depth_gre_r(i);
            d_id = 1;
            id_pix = i;
        end
        
        if(edge_r(i) == 1)
            edge_find_count = edge_find_count + 1;
            if(vec_r(i) < upper && vec_r(i) > lower && abs(vec_r(i)-mean)<mean_disp)
                mean_disp = abs(vec_r(i)-mean);
                direction = 1;
                edge_pix = i;
            end
        end
        
        depth_gre_l(i) = abs(vec_l(end-i) - vec_l(end+1-i));
        if(vec_l(end+1-i) < upper && vec_l(end+1-i) > lower && depth_gre_l(i) > gre_max)
            gre_max = depth_gre_l(i);
            d_id = 2;
            id_pix = i;
        end
        
        if(edge_l(end+1-i) == 1)
            edge_find_count = edge_find_count + 1;
            if(vec_l(end+1-i) < upper && vec_l(end+1-i) > lower && abs(vec_l(end+1-i)-mean)<mean_disp)
                mean_disp = abs(vec_l(end+1-i)-mean);
                direction = 2;
                edge_pix = i;
            end
        end
        
        depth_gre_d(i) = abs(vec_d(i+1) - vec_d(i));
        if(vec_d(i) < upper && vec_d(i) > lower && depth_gre_d(i) > gre_d_max)
            gre_max = depth_gre_d(i);
            d_id = 3;
            id_pix = i;
        end
        
        if(edge_d(i) == 1)
            edge_find_count = edge_find_count + 1;
            if(vec_d(i) < upper && vec_d(i) > lower && abs(vec_d(i)-mean)<mean_disp)
                mean_disp = abs(vec_d(i)-mean);
                direction = 3;
                edge_pix = i;
            end
        end
        
        depth_gre_u(i) = abs(vec_u(end-i) - vec_u(end+1-i));
        if(vec_u(end+1-i) < upper && vec_u(end+1-i) > lower && depth_gre_u(i) > gre_max)
            gre_max = depth_gre_u(i);
            d_id = 4;
            id_pix = i;
        end
        
        if(edge_u(end+1-i) == 1 )
            edge_find_count = edge_find_count + 1;
            if(vec_u(end+1-i) < upper && vec_u(end+1-i) > lower && abs(vec_u(end+1-i)-mean)<mean_disp)
                mean_disp = abs(vec_u(end+1-i)-mean);
                direction = 4;
                edge_pix = i;
            end
        end 
    end
        
    if(direction ~= 0 && edge_find_count <5 &&edge_pix > min_thres)%depth edge can be found and the pixel is reasonable
        flag = 1;%already refine
        if(direction == 1 )
            y_f = y + edge_pix;
        end
        if(direction == 2)
            y_f = y - edge_pix;
        end
        if(direction == 3)
            x_f = x + edge_pix;
        end
        if(direction == 4)
            x_f = x - edge_pix;
        end
    else
        %flag = 2;
        if(d_id == 1)
            y_f = y + id_pix;
        end
        if(d_id == 2)
            y_f = y - id_pix;
        end
        if(d_id == 3)
            x_f = x + id_pix;
        end
        if(d_id == 4)
            x_f = x - id_pix;
        end
    end
    
  
end