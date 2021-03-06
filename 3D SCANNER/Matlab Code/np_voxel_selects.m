function b=np_voxel_selects()  %0 if no voxels selected
load('workspace1.mat');

c=0;

b=0;
%fprintf(fid,'inside np voxel selects \n');

%{
%++++++++++++++++++++++++++++++++++++++++
temp=[];
for i=1:1:size(bdry_3d(pass-1).pass,1)
    for j=1:1:size(TRI_3d(pass-1).pass,1)
        if(~isempty(find(TRI_3d(pass-1).pass(j,:)==bdry_3d(pass-1).pass(i,1),1)) & ~isempty(find(TRI_3d(pass-1).pass(j,:)==bdry_3d(pass-1).pass(i,2),1)))
            temp=[temp;i];
            fprintf(fid,' %d \n',i);
            break;
        end
    end
end

bdry_3d(pass-1).pass(temp,:)=[];
%++++++++++++++++++++++++++++++++++++++++
%}

%++++++++++++++++++++++++++++++++++++++++
%[com f s]=intersect(bdry_3d(pass-1).pass,edge_total,'rows');
%edge_total(s,:)=[];
%save('workspace1.mat');
%++++++++++++++++++++++++++++++++++++++++

for i=1:1:x2
    for j=1:1:y2
        for k=1:1:z2
            
            voxel(i,j,k).consider=1;
            len=size(voxel(i,j,k).ll,2);
            if(len==0)
                continue;
            end
            
            %{
            % voxels which have all points unused are ready for next pass
            
            tmp=0;
            %fprintf(fid,' voxel %d %d %d is nonempty \n',i,j,k);
            for p=1:1:len
                %fprintf(fid,'pt : %d \n',voxel(i,j,k).ll(p));
                if(~isempty(find(TRI_total==voxel(i,j,k).ll(p),1)))
                    %fprintf(fid,' pt already in TRI_total \n')
                    tmp=1;
                    break;
                end
            end
            
            
            if(tmp==0)
                %fprintf(fid,' no pts in this voxel are present in TRI_total \n')
                voxel(i,j,k).consider=[];
                c=c+1;
                fprintf(fid,'voxel %d %d %d is ready for next pass \n',i,j,k);
                b=1;
            end
            
            %}
            
            
            %fprintf(fid,' voxel %d %d %d is nonempty \n',i,j,k);
            for p=1:1:len
                %fprintf(fid,'pt : %d \n',voxel(i,j,k).ll(p));
                
                %if(isempty(find(TRI_total==voxel(i,j,k).ll(p),1)) || ~isempty(find(bdry_3d(pass-1).pass==voxel(i,j,k).ll(p),1)))
                if(isempty(find(TRI_total==voxel(i,j,k).ll(p),1))) 
                    %fprintf(fid,' pt not present  in TRI_total \n')
                    voxel(i,j,k).consider=[];
                    fprintf(fid,'voxel %d %d %d is ready for next pass \n',i,j,k);
                    c=c+1;
                    b=1;
                    break;
                end
            end       
            
     
        end
    end
end
fprintf(fid,'c(no of voxel selects) : %d\n',c);
save('workspace1.mat');
end
