function [x_f,y_f] = refine(x,y,thres,depth_map,upper,lower)
    %x is hang ,y is lie!
    x_f = x;y_f = y;
    up = x - thres;
    down = x + thres;
    right = y + thres;
    left = y - thres;
    vec_r = depth_map(x,y:right);
    vec_l = depth_map(x,left:y);
    vec_u = depth_map(up:x,y);
    vec_d = depth_map(x:down,y);
    gre_r_max = 0;gre_l_max = 0;gre_d_max = 0;gre_u_max = 0;
    for i = 1 : thres
        %gre
        depth_gre_r(i) = abs(vec_r(i+1) - vec_r(i));
        if(vec_r(i) < upper && vec_r(i) > lower && depth_gre_r(i) > gre_r_max)
            gre_r_max = depth_gre_r(i);
        end
        depth_gre_l(i) = abs(vec_l(end-i) - vec_l(end+1-i));
        if(vec_l(end+1-i) < upper && vec_l(end+1-i) > lower && depth_gre_l(i) > gre_l_max)
            gre_l_max = depth_gre_l(i);
        end
        depth_gre_d(i) = abs(vec_d(i+1) - vec_d(i));
        if(vec_d(i) < upper && vec_d(i) > lower && depth_gre_d(i) > gre_d_max)
            gre_d_max = depth_gre_d(i);
        end
        depth_gre_u(i) = abs(vec_u(end-i) - vec_u(end+1-i));
        if(vec_u(end+1-i) < upper && vec_u(end+1-i) > lower && depth_gre_u(i) > gre_u_max)
            gre_u_max = depth_gre_u(i);
        end 
    end
    vec_max = [gre_r_max,gre_l_max,gre_d_max,gre_u_max];
    [v,id]=max(vec_max);
  
    if (v ~= 0)
        
        %pix = find(vec_max(id)==v);
        if(id == 1)
            pix = find(depth_gre_r == v);
            y_f = y + pix;
        end
        if(id == 2)
            pix = find(depth_gre_l == v);
            y_f = y - pix;
        end
        if(id == 3)
            pix = find(depth_gre_d == v);
            x_f = x + pix;
        end
        if(id == 4)
            pix = find(depth_gre_u == v);
            x_f = x - pix;
        end
    end
    %the results of this funcion is also xy for the image    
   

end