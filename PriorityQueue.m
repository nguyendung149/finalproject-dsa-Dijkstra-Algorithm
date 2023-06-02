classdef PriorityQueue <handle
    properties 
        heap % The min-heap used to store the elements
        size % The current size of the heap
    end
    
    methods 
        function obj = PriorityQueue()
            obj.heap = struct('element', {}, 'priority', {});
            obj.size = 0;
        end
        
        function push(obj, ele, pri)
            obj.size = obj.size + 1;
            obj.heap(obj.size).element = ele;
            obj.heap(obj.size).priority = pri;
            obj.siftUp(obj.size);
        end
        
        function element = pop(obj)
            if obj.size == 0
                error('Priority queue is empty');
            end
            element = obj.heap(1).element;
            obj.heap(1) = obj.heap(obj.size);
            obj.size = obj.size - 1;
            obj.siftDown(1);
        end
        
        function isEmpty = isEmpty(obj)
            isEmpty = (obj.size == 0);
        end
    end
    
    methods (Access = private)
        function siftUp(obj, index)
            parent = floor(index / 2);
            while index > 1 && obj.heap(index).priority < obj.heap(parent).priority
                obj.swap(index, parent);
                index = parent;
                parent = floor(index / 2);
            end
        end
        
        function siftDown(obj, index)
            while true
                leftChild = 2 * index;
                rightChild = 2 * index + 1;
                smallest = index;
                
                if leftChild <= obj.size && obj.heap(leftChild).priority < obj.heap(smallest).priority
                    smallest = leftChild;
                end
                
                if rightChild <= obj.size && obj.heap(rightChild).priority < obj.heap(smallest).priority
                    smallest = rightChild;
                end
                
                if smallest == index
                    break;
                end
                
                obj.swap(index, smallest);
                index = smallest;
            end
        end
        
        function swap(obj, index1, index2)
            temp = obj.heap(index1);
            obj.heap(index1) = obj.heap(index2);
            obj.heap(index2) = temp;
        end
    end
end
