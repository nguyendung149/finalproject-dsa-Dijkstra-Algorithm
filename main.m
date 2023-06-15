clc,clear all,close all;
% Define the range of graph sizes to test
nValues = 10:10:3000;
p = 1;
% Measure the execution time for different graph sizes
timeElapsed = zeros(size(nValues));
for i = 1:length(nValues)
    % Generate a random graph
    n = nValues(i);
    graph = rand(n) < p;

    % Select random start and end nodes
    startNode = randi(n);
    endNode = randi(n);

    % Measure the time it takes to execute the function
    tic;
    dijkstraShortestPath(graph, startNode, endNode);
    timeElapsed(i) = toc;
end
% Plot the results
figure(2);
%hồi quy tuyến tính theo ham log
mdl = fitlm(nValues', log(timeElapsed'), 'Intercept', true);
time_fit = exp(predict(mdl, nValues'));
plot(nValues', time_fit, 'r-', 'LineWidth', 2);
xlabel('Number of nodes');
ylabel('Execution time (s)');
title('Execution time as a function of graph size');
legend('Measured time','Location', 'northwest')
% Fit a curve to the data and plot the expected time complexity
figure(3);
nEdges = nValues .* (nValues - 1) / 2 * p; % expected number of edges
logNValues = log2(nValues);
logExpectedTime = log2(nEdges) + log2(logNValues);
expectedTime = 2.^(logExpectedTime);
hold on;
plot(nValues, expectedTime, '--', 'LineWidth', 2);
legend( 'Complexity (using nVertice and nEdge) ', 'Location', 'northwest');
