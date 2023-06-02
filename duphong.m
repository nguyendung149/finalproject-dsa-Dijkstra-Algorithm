% Tạo một đồ thị
graph = [
    0 4 0 0 0 0 0 8 0;
    4 0 8 0 0 0 0 11 0;
    0 8 0 7 0 4 0 0 2;
    0 0 7 0 9 14 0 0 0;
    0 0 0 9 0 10 0 0 0;
    0 0 4 14 10 0 2 0 0;
    0 0 0 0 0 2 0 1 6;
    8 11 0 0 0 0 1 0 7;
    0 0 2 0 0 0 6 7 0;
];

% Thiết lập các nút bắt đầu và kết thúc% Node bắt đầu và kết thúc
startNode = 1;
endNode = 5;

% Gán điểm số vô cùng cho mỗi nút
currentScore = Inf(size(graph, 1), 1);

% Thiết lập điểm số hiện tại của nút bắt đầu là 0
currentScore(startNode) = 0;

% Thêm tất cả các nút vào tập chưa duyệt
unvisited = 1:size(graph, 1);

% Vòng lặp chính
while ~isempty(unvisited)
    % Chọn nút có điểm số hiện tại thấp nhất và loại bỏ khỏi tập chưa duyệt
    [~, currentIndex] = min(currentScore(unvisited));
    currentNode = unvisited(currentIndex);
    unvisited(currentIndex) = [];
    
    % Tìm tất cả các láng giềng chưa duyệt của nút hiện tại
    unvisitedNeighbors = find(graph(currentNode,:) ~= 0 & ismember(1:size(graph, 1), unvisited));
    
    % Duyệt qua các láng giềng
    for i = 1:length(unvisitedNeighbors)
        neighbor = unvisitedNeighbors(i);
        tentativeScore = currentScore(currentNode) + graph(currentNode, neighbor);
        if tentativeScore < currentScore(neighbor)
            % Cập nhật điểm số hiện tại của láng giềng
            currentScore(neighbor) = tentativeScore;
        end
    end
    
    % Kiểm tra điều kiện dừng
    if isempty(unvisited)
        % Tất cả các nút đều đã được duyệt và không có đường đi đến nút kết thúc
        disp('No path found');
        break;
    elseif currentScore(endNode) < Inf
        % Đã tìm thấy đường đi đến nút kết thúc
        disp('Path found');
        break;
    end
end
T4 18:09
Bảo Bảo
Lê Tấn Bảo Bảo
function dijkstraShortestPath(graph, startNode, endNode)

% Gán điểm số vô cùng cho mỗi nút
currentScore = Inf(size(graph, 1), 1);

% Thiết lập điểm số hiện tại của nút bắt đầu là 0
currentScore(startNode) = 0;

% Thêm tất cả các nút vào tập chưa duyệt
unvisited = 1:size(graph, 1);

% Vòng lặp chính
while ~isempty(unvisited)
    % Chọn nút có điểm số hiện tại thấp nhất và loại bỏ khỏi tập chưa duyệt
    [~, currentIndex] = min(currentScore(unvisited));
    currentNode = unvisited(currentIndex);
    unvisited(currentIndex) = [];
    
    % Tìm tất cả các láng giềng chưa duyệt của nút hiện tại
    unvisitedNeighbors = find(graph(currentNode,:) ~= 0 & ismember(1:size(graph,1), unvisited));
    
    % Duyệt qua các láng giềng
    for i = 1:length(unvisitedNeighbors)
        neighbor = unvisitedNeighbors(i);
        tentativeScore = currentScore(currentNode) + graph(currentNode, neighbor);
        if tentativeScore < currentScore(neighbor)
            % Cập nhật điểm số hiện tại của láng giềng
            currentScore(neighbor) = tentativeScore;
        end
    end
    
    % Kiểm tra điều kiện dừng
    if isempty(unvisited)
        % Tất cả các nút đều đã được duyệt và không có đường đi đến nút kết thúc
        disp('No path found');
        break;
    elseif currentScore(endNode) < Inf
        % Đã tìm thấy đường đi đến nút kết thúc
        disp('Path found');
        break;
    end
end 

% In ra đường đi
if currentScore(endNode) < Inf
    path = endNode;
    while path(1) ~= startNode
        neighbors = find(graph(path(1),:) ~= 0);
        [~, minIndex] = min(currentScore(neighbors));
        path = [neighbors(minIndex), path];
    end
    disp(['Path: ', num2str(path)]);
    
    %In đường đi trên biểu đồ đồ thị
    G = digraph(graph);
    highlight(G, path, 'EdgeColor', 'r', 'LineWidth', 2);
    plot(G, 'Layout', 'force');
end