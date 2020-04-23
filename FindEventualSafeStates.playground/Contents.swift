/**
 In a directed graph, we start at some node and every turn, walk along a directed edge of the graph.
 If we reach a node that is terminal (that is, it has no outgoing directed edges), we stop.

 Now, say our starting node is eventually safe if and only if we must eventually walk to a
 terminal node. More specifically, there exists a natural number K so that for any choice of
 where to walk, we must have stopped at a terminal node in less than K steps.

 Which nodes are eventually safe?  Return them as an array in sorted order.

 The directed graph has N nodes with labels 0, 1, ..., N-1, where N is the length of graph.
 The graph is given in the following form: graph[i] is a list of labels j such that (i, j) is
 a directed edge of the graph.

 Example:
 Input: graph = [[1,2],[2,3],[5],[0],[5],[],[]]
 Output: [2,4,5,6]
 Here is a diagram of the above graph.
 */
class Solution {
    enum State {
        case unvisited, unsafe, safe
    }

    /**
     We use DFS recursively to calculate safe nodes. If we mark a starting node as unsafe, and recurse
     into its neighbors and eventually end up at an unsafe node again (base case), then we have
     our answer. Otherwise. nodes will be safe.
     - Complexity: O(n + e) where n is the number of nodes in the graph, and e is the edges.
     O(n) space for recursion call stack space.
     */
    func eventualSafeNodes(_ graph: [[Int]]) -> [Int] {
        var res = [Int]()

        guard graph.count > 0 else {
            return res
        }

        var states = [State].init(repeating: .unvisited, count: graph.count)

        for i in 0..<graph.count {
            if isSafeDFS(graph, i, &states) {
                res.append(i)
            }
        }

        return res
    }

    private func isSafeDFS(_ graph: [[Int]], _ start: Int, _ states: inout [State]) -> Bool {
        if states[start] != .unvisited {
            return states[start] == .safe
        }

        states[start] = .unsafe
        for next in graph[start] {
            if states[next] == .safe {
                continue
            }

            if states[next] == .unsafe || !isSafeDFS(graph, next, &states) {
                return false
            }
        }

        states[start] = .safe
        return true
    }
}

print(Solution().eventualSafeNodes([[1,2],[2,3],[5],[0],[5],[],[]]))
