clc
close all;
clear all;
warning off

v = VideoReader('input.mp4');
disp(v.NumFrames);
vidOut1 = VideoWriter('Output1');
open(vidOut1)
vidOut2 = VideoWriter('Output2');
open(vidOut2)


%%%%% For input images
% for ii = 1:v.NumFrames
%     I = read(v, ii);
%     ImgName = strcat(int2str(ii),'.jpg');
%     ImgName = strcat("D:\User Documents\Downloads\Advanced Media Lab MatLab (DMET1002)\Final Project\Input Images\", ImgName);
%     imwrite(I, ImgName); 
% end


for ii = 1:v.NumFrames
    detector = peopleDetectorACF;
    I = read(v, ii);
    [bboxes,scores] = detect(detector,I);
    blackimg1 = zeros(480,720,3,'uint8');
    blackimg2 = zeros(480,720,3,'uint8');
    disp(bboxes);
    disp(scores);
    if scores ~= 0
        if isequal(size(scores),[2,1])
            box1 = [bboxes(1),bboxes(3),bboxes(5),bboxes(7)];
            box2 = [bboxes(2),bboxes(4),bboxes(6),bboxes(8)];        
            cropped_object1 = imcrop(I,box1);
            cropped_object2 = imcrop(I,box2);
            blackimg1(box1(2):box1(2)+box1(4), box1(1):box1(1)+box1(3),:) = cropped_object1;
            blackimg2(box2(2):box2(2)+box2(4), box2(1):box2(1)+box2(3),:) = cropped_object2;
            
            ImgName = strcat(int2str(ii),'.jpg');
            ImgName1 = strcat("D:\User Documents\Downloads\Advanced Media Lab MatLab (DMET1002)\Final Project\Ouput Images 1\", ImgName);
            ImgName2 = strcat("D:\User Documents\Downloads\Advanced Media Lab MatLab (DMET1002)\Final Project\Output Images 2\", ImgName);
            imwrite(blackimg1, ImgName1);
            imwrite(blackimg2, ImgName2); 

        else
            box1 = [bboxes(1),bboxes(2),bboxes(3),bboxes(4)];
            cropped_object1 = imcrop(I,box1);
            blackimg1(box1(2):box1(2)+box1(4), box1(1):box1(1)+box1(3),:) = cropped_object1;
            
            ImgName = strcat(int2str(ii),'.jpg');
            ImgName1 = strcat("D:\User Documents\Downloads\Advanced Media Lab MatLab (DMET1002)\Final Project\Ouput Images 1\", ImgName);
            ImgName2 = strcat("D:\User Documents\Downloads\Advanced Media Lab MatLab (DMET1002)\Final Project\Output Images 2\", ImgName);
            imwrite(blackimg1, ImgName1);
            imwrite(blackimg1, ImgName2); 
        end 
    else
        disp("No people present in this Frame");
        ImgName1 = strcat(int2str(ii),'.jpg');
        ImgName2 = strcat(int2str(ii),'.jpg');
        ImgName1 = strcat("D:\User Documents\Downloads\Advanced Media Lab MatLab (DMET1002)\Final Project\Ouput Images 1\", ImgName1);
        ImgName2 = strcat("D:\User Documents\Downloads\Advanced Media Lab MatLab (DMET1002)\Final Project\Output Images 2\", ImgName2);
        imwrite(blackimg1, ImgName1); 
        imwrite(blackimg2, ImgName2); 
    end
end


for iii = 1:v.NumFrames
  IN1 = strcat(int2str(iii),'.jpg');
  IN1 = strcat("D:\User Documents\Downloads\Advanced Media Lab MatLab (DMET1002)\Final Project\Ouput Images 1\", IN1);
  frame1 = imread(IN1);
  writeVideo(vidOut1, frame1);
end

close(vidOut1)

for iii = 1:v.NumFrames
  IN2 = strcat(int2str(iii),'.jpg');
  IN2 = strcat("D:\User Documents\Downloads\Advanced Media Lab MatLab (DMET1002)\Final Project\Output Images 2\", IN2);
  frame2 = imread(IN2);
  writeVideo(vidOut2, frame2);
end
    
close(vidOut2)