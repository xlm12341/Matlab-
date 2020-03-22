clear;
% matching img's histogram to ref's histogram.

ref = imread('.\\asset\\woman.jpg');
img = imread('.\\asset\\ironman.jpg');
 
[H, W, x] = size(img);
out = zeros(H, W, x);
for k = 1:3
    disp(k);
    hist_ref = imhist(ref(:, :, k));    % ref的直方图
    cumHist_ref = []; %ref的累积直方图
    for i=1:256
        cumHist_ref = [cumHist_ref sum(hist_ref(1:i))];
    end
  
    img1 = img(:, :, k);
    hist_img = imhist(img1); %img的直方图
    cumHist_img = []; %img的累积直方图
    for i=1:256
        cumHist_img = [cumHist_img sum(hist_img(1:i))];
    end
  
    for i=1:256
        tmp{i} = cumHist_ref - cumHist_img(i);
        tmp{i} = abs(tmp{i});               % 找到两个累积直方图距离最近的点
        [a, index(i)] = min(tmp{i});       % a是tmp{i}中最小的值，index是该值对应的下标
    end
  
    imgn = zeros(H,W);
    for i = 1:H
        for j = 1:W
            imgn(i,j) = index(img1(i,j)+1)-1;    % 由原图的灰度通过索引映射到新的灰度
        end
    end
    out(:, :, k) = imgn;
end
 
out=uint8(out);
figure; imshow(out); title('product')
disp('Done');