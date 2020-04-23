protocol Queue {
    associatedtype DataType: Comparable

    /**
     Inserts a new item into the queue.
     - parameter item: The item to add.
     - returns: Whether or not the insert was successful.
     */
    @discardableResult func add(_ item: DataType) -> Bool

    /**
     Removes the first item in line.
     - returns: The removed item.
     - throws: An error of type QueueError.
     */
    @discardableResult func remove() throws -> DataType

    /**
     Gets the first item in line and removes it from the queue.
     - returns: An Optional containing the first item in the queue.
     */
    func dequeue() -> DataType?

    /**
     Gets the first item in line, without removing it from the queue.
     - returns: An Optional containing the first item in the queue.
     */
    func peek() -> DataType?

    /**
     Clears the queue.
     */
    func clear() -> Void
}

enum QueueError: Error {
  case noSuchItem(String)
}

/**
 A PriorityQueue implementation based on a Heap data structure.
 */

class PriorityQueue<DataType: Comparable>: Queue {
    /**
     The backing storage for our queue.
     */
    private var queue: Array<DataType>

    /**
     The current size of the queue.
     */
    public var size: Int {
        return self.queue.count
    }

    public init() {
        self.queue = Array<DataType>()
    }

    @discardableResult
    public func add(_ item: DataType) -> Bool {
        self.queue.append(item)
        self.heapifyUp(from: self.queue.count - 1)
        return true
    }

    @discardableResult
    public func remove() throws -> DataType {
        guard self.queue.count > 0 else {
            throw QueueError.noSuchItem("Attempt to remove item from an empty queue.")
        }
        return self.popAndHeapifyDown()
    }

    public func dequeue() -> DataType? {
        guard self.queue.count > 0 else {
            return nil
        }
        return self.popAndHeapifyDown()
    }

    public func peek() -> DataType? {
        return self.queue.first
    }

    public func clear() {
        self.queue.removeAll()
    }

    /**
     Pops the first item in the queue and restores the min heap order of the queue by moving the root item towards the end of the queue.
     - returns: The first item in the queue.
     */
    private func popAndHeapifyDown() -> DataType {
        let firstItem = self.queue[0]

        if self.queue.count == 1 {
            self.queue.remove(at: 0)
            return firstItem
        }

        self.queue[0] = self.queue.remove(at: self.queue.count - 1)

        self.heapifyDown()

        return firstItem
    }

    /**
     Restores the min heap order of the queue by moving an item towards the beginning of the queue.
     - parameter index: The index of the item to move.
     */
    private func heapifyUp(from index: Int) {
        var child = index
        var parent = child.parent

        while parent >= 0 && self.queue[parent] > self.queue[child] {
            swap(parent, with: child)
            child = parent
            parent = child.parent
        }
    }

    /**
     Restores the min heap order of the queue by moving the root item towards the end of the queue.
     */
    private func heapifyDown() {
        var parent = 0

        while true {
            let leftChild = parent.leftChild
            if leftChild >= self.queue.count {
                break
            }

            let rightChild = parent.rightChild
            var minChild = leftChild
            if rightChild < self.queue.count && self.queue[minChild] > self.queue[rightChild] {
                minChild = rightChild
            }

            if self.queue[parent] > self.queue[minChild] {
                self.swap(parent, with: minChild)
                parent = minChild
            } else {
                break
            }
        }
    }

    /**
     Swaps the items located at two different indices in our backing storage.
     - parameter firstIndex: The index of the first item to swap.
     - parameter secondIndex: The index of the second item to swap.
     */
    private func swap(_ firstIndex: Int, with secondIndex: Int) {
        let firstItem = self.queue[firstIndex]
        self.queue[firstIndex] = self.queue[secondIndex]
        self.queue[secondIndex] = firstItem
    }
}

private extension Int {
    var leftChild: Int {
        return (2 * self) + 1
    }

    var rightChild: Int {
        return (2 * self) + 2
    }

    var parent: Int {
        return (self - 1) / 2
    }
}

extension PriorityQueue: CustomStringConvertible {
  public var description: String {
    return self.queue.description
  }
}

class Node: Comparable {

    var vertex: Int
    var distance: Int

    init(_ v: Int, _ dist: Int) {
        vertex = v
        distance = dist
    }

    static func < (lhs: Node, rhs: Node) -> Bool {
        return lhs.distance < rhs.distance
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.distance == rhs.distance
    }
}

/**
 There are N network nodes, labelled 1 to N.
 Given times, a list of travel times as directed edges times[i] = (u, v, w), where u is the
 source node, v is the target node, and w is the time it takes for a signal to travel from
 source to target.

 Now, we send a signal from a certain node K. How long will it take for all nodes to receive
 the signal? If it is impossible, return -1.

 Example 1:
 Input: times = [[2,1,1],[2,3,1],[3,4,1]], N = 4, K = 2
 Output: 2
 */

class Solution {
    /**
     Dijkstra's shortest path implementation using a min-heap.
     - Complexity: O(e log e) because potentially every edge gets added to the heap. O(n + e) space for the size of graph.
     */
    func networkDelayTime(_ times: [[Int]], _ N: Int, _ K: Int) -> Int {
        var graph: [Int: [[Int]]] = [:]

        // This map keeps track of the distance from node N to K
        var distMap: [Int: Int] = [:]
        let bfsQueue = PriorityQueue<Node>()

        // Create an adjacency table out of the list of edges
        for edge in times {
            graph[edge[0], default: []].append([edge[1], edge[2]])
        }

        // Kick off the BFS with target node K being 0 distance away from itself
        bfsQueue.add(Node(K, 0))

        while bfsQueue.size != 0 {
            let node = bfsQueue.dequeue()!

            // If we haven't visited this vertex before, add it to the distance map
            if distMap[node.vertex] == nil {
                // Store a value from node N to K
                distMap[node.vertex] = node.distance
            }

            // Enumerate the neighboring vertices
            if let adjacentNodes = graph[node.vertex] {
                for edge in adjacentNodes {
                    let n = edge[0]
                    let distToNeighbor = edge[1]

                    if distMap[n] == nil {
                        bfsQueue.add(Node(n, node.distance + distToNeighbor))
                    }
                }
            }
        }

        // If our distance map doesn't contain the same number of nodes as input N,
        // some nodes are unreachable, making it impossible to reach all nodes!
        if distMap.keys.count != N {
            return -1
        }

        print(distMap)

        // Scan through the distance map and return the highest value
        return distMap.values.max() ?? -1
    }
}

print(Solution().networkDelayTime([[2,1,1],[2,3,1],[3,4,1]], 4, 2))
