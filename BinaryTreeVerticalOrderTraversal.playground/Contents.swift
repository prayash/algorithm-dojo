/**
 Given a binary tree, return the vertical order traversal of its nodes values.

 For each node at position (X, Y), its left and right children respectively will be at
 positions (X-1, Y-1) and (X+1, Y-1).

 Running a vertical line from X = -infinity to X = +infinity, whenever the vertical line
 touches some nodes, we report the values of the nodes in order from top to bottom
 (decreasing Y coordinates).

 If two nodes have the same position, then the value of the node that is reported first
 is the value that is smaller.

 Return an list of non-empty reports in order of X coordinate.  Every report will have a
 list of values of nodes.

     Input: [3,9,20,null,null,15,7]
     Output: [[9],[3,15],[20],[7]]
     Explanation:
     Without loss of generality, we can assume the root node is at position (0, 0):
     Then, the node with value 9 occurs at position (-1, -1);
     The nodes with values 3 and 15 occur at positions (0, 0) and (0, -2);
     The node with value 20 occurs at position (1, -1);
     The node with value 7 occurs at position (2, -2).
 */

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

typealias Node = TreeNode
class Solution {
    /**
     We can find the location of every node using DFS. During search, we'll maintain a
     location struct to record the coordinates of each node. We then sort them by x and y so they're in the correct order.
     - Complexity: O(n log n) for sorting and DFS traversal. O(n) space to store nodes.
     */
    func verticalTraversal(_ root: Node?) -> [[Int]] {
        var result: [[Int]] = [[Int]()]
        var locations: [Location] = []

        dfs(root, 0, 0, &locations)
        locations.sort()

        // Cache the latest x value to keep track of horizontal movement
        var prevX = locations[0].x

        for location in locations {
            // If the x value changed, it's part of a new report.
            if location.x > prevX {
                prevX = location.x

                // We're now at a new horizontal distance, so append a new list
                result.append([Int]())
            }

            // We always add the node's value to the latest report.
            result[result.count - 1].append(location.val)
        }

        return result
    }

    private func dfs(_ node: Node?, _ x: Int, _ y: Int, _ locations: inout [Location]) {
        guard let node = node else { return }

        locations.append(Location(x: x, y: y, val: node.val))
        dfs(node.left, x - 1, y + 1, &locations)
        dfs(node.right, x + 1, y + 1, &locations)
    }
}

struct Location: Comparable, CustomStringConvertible {
    var x: Int
    var y: Int
    var val: Int

    static func < (lhs: Location, rhs: Location) -> Bool {
        if lhs.x != rhs.x {
            return lhs.x < rhs.x
        } else if lhs.y != rhs.y {
            return lhs.y < rhs.y
        } else {
            return lhs.val < rhs.val
        }
    }

    var description: String {
        return "(x: \(x), y: \(y), val: \(val))"
    }
}

let root = Node(3)
root.left = Node(9)
root.right = Node(20)
root.right?.left = Node(15)
root.right?.right = Node(7)

print(Solution().verticalTraversal(root))
