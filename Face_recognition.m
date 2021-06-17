%load dataset
loaded_Image=load_database();

%random function generated a random index
random_Index=round(1000*rand(1,1));          
random_Image=loaded_Image(:,random_Index);                         
rest_of_the_images=loaded_Image(:,[1:random_Index-1 random_Index+1:end]);   

image_Signature=20;                            
white_Image=uint8(ones(1,size(rest_of_the_images,2)));

mean_value=uint8(mean(rest_of_the_images,2));                
mean_Removed=rest_of_the_images-uint8(single(mean_value)*single(white_Image));

L=single(mean_Removed)'*single(mean_Removed);
[V,D]=eig(L);
V=single(mean_Removed)*V;
V=V(:,end:-1:end-(image_Signature-1));       

all_image_Signature=zeros(size(rest_of_the_images,2),image_Signature);
for i=1:size(rest_of_the_images,2);
    all_image_Signature(i,:)=single(mean_Removed(:,i))'*V;  
end
subplot(121);
imshow(reshape(random_Image,112,92));
title('Looking for this Face','FontWeight','bold','Fontsize',16,'color','black');
subplot(122);
p=random_Image-mean_value;
s=single(p)'*V;
z=[];
for i=1:size(rest_of_the_images,2)
    z=[z,norm(all_image_Signature(i,:)-s,2)];
    %rem: Compute the remainder after dividing a into b.
    if(rem(i,20)==0),imshow(reshape(rest_of_the_images(:,i),112,92)),end;
    %updates figures and processes any pending callbacks. Use this command if you modify graphics objects and want to see the updates on the screen immediately
    drawnow; 
end
%compute the smallest elements in each column as well as the column indices of z in which they appear.
[a,i]=min(z);
subplot(122);
imshow(reshape(rest_of_the_images(:,i),112,92));
title('Recognition Completed','FontWeight','bold','Fontsize',16,'color','black');