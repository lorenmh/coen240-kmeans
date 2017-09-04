%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lauren Howard - W1287305
% COEN 240 - Coding Assignment 7
% kmeans.m

% This script performs kmeans clustering on simple_iris_dataset.dat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all;

% X is the dataset size 100x2
%   Column 1: sepal length
%   Column 2: sepal width
X = dlmread('simple_iris_dataset.dat');  % Size=100x2
N = length(X);  % N=100

% Initialization - take 2 random samples from data set
ctr1 = X(randi([1,N]),:);
ctr2 = X(randi([1,N]),:);

counter = 0;

while true
  repc1 = repmat(ctr1, N, 1);
  repc2 = repmat(ctr2, N, 1);

  deltas1 = X - repc1;
  deltas2 = X - repc2;

  % distance to centroid 1
  d1 = arrayfun(@(dx,dy) hypot(dx,dy), deltas1(:,1), deltas1(:,2));

  % distance to centroid 2
  d2 = arrayfun(@(dx,dy) hypot(dx,dy), deltas2(:,1), deltas2(:,2));

  oldctr1 = ctr1;
  oldctr2 = ctr2;

  ctr1 = mean(X(d1<d2,:));
  ctr2 = mean(X(d1>=d2,:));

  % convergence test
  if oldctr1 == ctr1 && oldctr2 == ctr2
    break;
  end

  counter += 1;
end

printf('Number of iterations to converge = %d\n', counter);

figure; hold on;

xlabel('Sepal Length');
ylabel('Sepal Width');

idx_c1 = find(d1<d2);
idx_c2 = find(d1>=d2);

% Plot clustered data with two different colors; X is 100x2
plot(X(idx_c1,1),X(idx_c1,2),'r.','MarkerSize',12)
plot(X(idx_c2,1),X(idx_c2,2),'b.','MarkerSize',10)

% Plot centroid of each cluster
plot(ctr1(:,1),ctr1(:,2), 'kx', 'MarkerSize',12,'LineWidth',2);
plot(ctr2(:,1),ctr2(:,2), 'ko', 'MarkerSize',12,'LineWidth',2);
