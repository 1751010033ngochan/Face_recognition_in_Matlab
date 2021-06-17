function output_value = load_database()

persistent loaded;
persistent numeric_Image;

%load the dataset only once so we need to check loaded variable is empty at
%the begining (Input)
if(isempty(loaded))
    %zeros => tao ma tran ma cac phan tu deu la zeros
    %We have 1000 images. Each of them have 92 x 112 = 10304 pixels. That is 
    %why we have to take 10304 zeros for 100 times
    %matrix => 10304 line, 100 column
    all_Images = zeros(10304,100);
    
    for i=1:100
        %num2str => chuyen 1 so sang xau ky tu
        cd(strcat('s',num2str(i)));
        for j=1:10
            image_Container = imread(strcat(num2str(j),'.pgm'));
            %toan tu ':' => tham chieu den tat ca cac toan tu cua 1 hang hay 1 cot. 
            %Ex: A(:,3) => cot, A(3,:) => hang
            all_Images(:,(i-1)*10+j) = reshape(image_Container,size(image_Container,1)*size(image_Container,2),1);
        end
        display('Doading Database');
        cd ..
    end
    numeric_Image = uint8(all_Images);   
end

loaded = 1;
output_value = numeric_Image;