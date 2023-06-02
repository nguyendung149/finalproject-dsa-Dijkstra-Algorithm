function dijkstraShortestPath(Graph, startNode, endNode)

% Gán điểm số vô cùng cho mỗi nút
currentScore = Inf(size(Graph, 1), 1);
% Thiết lập điểm số hiện tại của nút bắt đầu là 0
currentScore(startNode) = 0;

% Khởi tạo hàng đợi ưu tiên với nút bắt đầu và điểm số tương ứng
queue = PriorityQueue();
queue.push(startNode, currentScore(startNode));

% Vòng lặp chính
while ~queue.isEmpty()
    % Lấy nút có điểm số hiện tại thấp nhất từ hàng đợi ưu tiên
    currentNode = queue.pop();
    
    % Kiểm tra điều kiện dừng
    if currentNode == endNode
        % Đã tìm thấy đường đi đến nút kết thúc
        disp('Path found');
        break;
    end
    
    % Tìm tất cả các láng giềng của nút hiện tại
    neighbors = find(Graph(currentNode,:) ~= 0);
    
    % Duyệt qua các láng giềng
    for i = 1:length(neighbors)
        neighbor = neighbors(i);
        tentativeScore = currentScore(currentNode) + Graph(currentNode, neighbor);
        if tentativeScore < currentScore(neighbor)
            % Cập nhật điểm số hiện tại của láng giềng
            currentScore(neighbor) = tentativeScore;
            % Đẩy láng giềng vào hàng đợi ưu tiên với điểm số tương ứng
            queue.push(neighbor, tentativeScore);
        end
    end
end

% In ra đường đi
if currentScore(endNode) < Inf
    unvisited = 1:size(Graph,1);
    path = endNode;
    t = find(unvisited==endNode);
    unvisited(t) = [];
    a = unvisited;
    while path(1) ~= startNode
        neighbors = find(Graph(path(1),:) ~= 0 & ismember(1:size(Graph,1), unvisited));
        [~, minIndex] = min(currentScore(neighbors));
        if(currentScore(neighbors(minIndex))==(currentScore(path(1))-Graph(path(1),neighbors(minIndex))))
            path = [neighbors(minIndex), path];
            unvisited = a;
            index = find(unvisited==neighbors(minIndex));
            unvisited(index)=[];
            a(index) = [];
        else
            index = find(unvisited==neighbors(minIndex));
            unvisited(index)=[];
        end
    end
    disp(['Path: ', num2str(path)]);
    
    %In đường đi trên biểu đồ đồ thi
    weights = [];
    vertices = [];
    link = [];
    index = [];
    for k = 1:length(Graph)
        index = find(Graph(k,:) ~= 0);
        for j = 1:k
            temp = find(index == j);
            index(temp) = [];
        end
        weights = [weights Graph(k,index)];
        vertices = [vertices k*ones(1,length(Graph(k,index)))];
        link = [link index];
    end
    
     G = graph(vertices,link,weights,'omitselfloops');
    
     % Lấy danh sách các cạnh trong đường đi
    % Vẽ biểu đồ đồ thị với màu cạnh được thiết lập
    h = plot(G, 'Layout', 'force','EdgeLabel',G.Edges.Weight);
    title("Dijkstra's Algorithm Simulation")
    highlight(h, path, 'EdgeColor','r', 'LineWidth', 3);
    currentScore
end
end