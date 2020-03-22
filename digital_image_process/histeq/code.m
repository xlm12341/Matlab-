clear;
% matching img's histogram to ref's histogram.

ref = imread('.\\asset\\woman.jpg');
img = imread('.\\asset\\ironman.jpg');
 
[H, W, x] = size(img);
out = zeros(H, W, x);
for k = 1:3
    disp(k);
    hist_ref = imhist(ref(:, :, k));    % ref��ֱ��ͼ
    cumHist_ref = []; %ref���ۻ�ֱ��ͼ
    for i=1:256
        cumHist_ref = [cumHist_ref sum(hist_ref(1:i))];
    end
  
    img1 = img(:, :, k);
    hist_img = imhist(img1); %img��ֱ��ͼ
    cumHist_img = []; %img���ۻ�ֱ��ͼ
    for i=1:256
        cumHist_img = [cumHist_img sum(hist_img(1:i))];
    end
  
    for i=1:256
        tmp{i} = cumHist_ref - cumHist_img(i);
        tmp{i} = abs(tmp{i});               % �ҵ������ۻ�ֱ��ͼ��������ĵ�
        [a, index(i)] = min(tmp{i});       % a��tmp{i}����С��ֵ��index�Ǹ�ֵ��Ӧ���±�
    end
  
    imgn = zeros(H,W);
    for i = 1:H
        for j = 1:W
            imgn(i,j) = index(img1(i,j)+1)-1;    % ��ԭͼ�ĻҶ�ͨ������ӳ�䵽�µĻҶ�
        end
    end
    out(:, :, k) = imgn;
end
 
out=uint8(out);
figure; imshow(out); title('product')
disp('Done');