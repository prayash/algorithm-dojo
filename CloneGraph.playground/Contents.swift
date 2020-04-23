/**
 Given a reference of a node in a connected undirected graph, return a deep copy (clone) of the graph.
 Each node in the graph contains a val (int) and a list (List[Node]) of its neighbors.
 */

struct UndirectedGraphNode {
    var val: Int
    var neighbors: [UndirectedGraphNode?] = []
}

class Solution {
    func cloneGraph(_ root: UndirectedGraphNode?) -> UndirectedGraphNode? {
        var hashMap: [Int: UndirectedGraphNode] = [:]

        return dfs(root, &hashMap)
    }

    func dfs(_ node: UndirectedGraphNode?, _ map: inout [Int: UndirectedGraphNode]) -> UndirectedGraphNode? {
        guard let node = node else {
            return nil
        }

        if let clonedNode = map[node.val] {
            return clonedNode
        }

        var clone = UndirectedGraphNode(val: node.val)
        map[clone.val] = clone

        for neighbor in node.neighbors {
            if let node = dfs(neighbor, &map) {
                clone.neighbors.append(node)
            }
        }

        return clone
    }
}

var one = UndirectedGraphNode(val: 1)
var two = UndirectedGraphNode(val: 2)
var three = UndirectedGraphNode(val: 3)
var four = UndirectedGraphNode(val: 4)

one.neighbors = [two, four]
two.neighbors = [one, three]
three.neighbors = [two, four]
four.neighbors = [one, two]

print(Solution().cloneGraph(one)?.neighbors)
