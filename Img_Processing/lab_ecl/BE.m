%% Img transformation

clc; clear all; close all;

bus = imread('bus.jpeg');
simpson = imread('simpsons.jpeg');
figure; imshow(bus);

% format [x, y];
topleft = [584, 210];
topright = [798, 230];
bottomright = [808, 468];
bottomleft = [597, 522];

sourcePoints = [0, 0; 1000, 0; 1000, 1500; 0, 1500];
destinationPoints = [topleft; topright; bottomright; bottomleft];
tform = fitgeotrans(sourcePoints, destinationPoints, 'projective');
transformedSimpson = imwarp(simpson, tform);

figure; imshow(transformedSimpson);

s = size(transformedSimpson)
mask = cast(transformedSimpson ~= 0, "uint8");
bus(209:209 + s(1) - 1, 583:583 + s(2) - 1, :) = bus(209:209 + s(1) - 1, 583:583 + s(2) - 1, :) .* (1 - mask);
figure; imshow(bus);
bus(209:209 + s(1) - 1, 583:583 + s(2) - 1, :) = bus(209:209 + s(1) - 1, 583:583 + s(2) - 1, :) + transformedSimpson;
figure; imshow(bus);

mask2 = createMask();