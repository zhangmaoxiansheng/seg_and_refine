function [img] = get_area(id,R1,G1,B1)
    sz = size(id);
    height = sz(1);
    width = sz(2);
    img = zeros(height,width);
    for i = 1:height
        for j = 1:width
            R = id(i,j,1);
            G = id(i,j,2);
            B = id(i,j,3);
            if(R == R1 && G == G1 && B == B1)
                img(i,j) = 255;
            end
        end
    end
    %contours = bwboundaries(img);

end