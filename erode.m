id = index_t;
n = 5;
kernal = ones(2*n+1,2*n+1);
kernal(n+1,n+1)=0;
for i1 = 1:110
    edge_curr = edge(id,'canny');
    [x,y] = find(edge_curr);
    %n = 5;
    n = 5;
    if(i1>70)
        n=3;
    end
    if(i1>100)
        n=1;
    end
    kernal = ones(2*n+1,2*n+1);
    kernal(n+1,n+1)=0;
    for i=1:numel(x)
        %k = kkernal.*index_t(x(i)-n1:x(i)+n1,y(i)-n1:y(i)+n1);
        k2 = kernal.*god(x(i)-n:x(i)+n,y(i)-n:y(i)+n);
        if(isempty(find(k2,1))||depth(x(i),y(i))<lower||depth(x(i),y(i))>upper)
            id(x(i),y(i)) = 0;
        end
    
    end
end
% [lx,ly]=find(id);
% for li = 1:numel(lx)
%     if(lx(li)-319>0 && ly(li)-266>0)
%         if(lx(li)-319>138 || ly(li)-266>351)
%             id(lx(li),ly(li)) =0;
%         else if(test_bw(lx(li)-319,ly(li)-266)==1&&(depth(lx(li),ly(li))<lower||depth(lx(li),ly(li))>upper))
%                 id(lx(li),ly(li)) =0;
%             end
%         end
%     end
% end
imshow(id);
