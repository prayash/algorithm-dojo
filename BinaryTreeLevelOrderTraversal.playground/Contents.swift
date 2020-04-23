/**
 Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

 For example:
 Given binary tree [3, 9, 20, null, null, 15, 7]:
   3
  / \
 9  20
   /  \
  15   7

 return its level order traversal as:
 [
   [3],
   [9, 20],
   [15, 7]
 ]

 */

class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    /**
     Split-level BFS traversal. Recursive.
     O(n) time + O(n) space to keep the output structure which contains n values.
     */
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var levels: [[Int]] = []

        visit(root, level: 0, levels: &levels)

        return levels
    }

    func visit(_ node: TreeNode?, level: Int, levels: inout [[Int]]) {
        guard let node = node else {
            return
        }

        // We're at the same level, so keep appending.
        if level < levels.count {
            levels[level].append(node.val)
        } else {
            // We'll create a new once we've finished processing a level
            levels.append([node.val])
        }

        // If there are new levels to process, we'll do that, and increment the level value
        // which will append another list to the levels 2D array.

        if node.left != nil {
            visit(node.left, level: level + 1, levels: &levels)
        }

        if node.right != nil {
            visit(node.right, level: level + 1, levels: &levels)
        }
    }

    /**
     Split-level BFS traversal. Iterative using a queue.
     O(n) time + O(n) space to keep the output structure which contains n values.
     */
    func levelOrderIterative(_ root: TreeNode?) -> [[Int]] {
        func bfs(_ node: TreeNode?, levels: inout [[Int]]) {
            guard let node = node else { return }

            var level = 0
            var bfsQueue: [TreeNode] = [node]

            while !bfsQueue.isEmpty {
                levels.append([])

                for _ in 0..<bfsQueue.count {
                    let n = bfsQueue.removeFirst()

                    levels[level].append(n.val)

                    if let left = n.left {
                        bfsQueue.append(left)
                    }

                    if let right = n.right {
                        bfsQueue.append(right)
                    }
                }

                level += 1
            }

        }

        var levels: [[Int]] = []
        bfs(root, levels: &levels)
        return levels
    }
}

var root = TreeNode(3)
root.left = TreeNode(9)
root.right = TreeNode(20)
root.right?.left = TreeNode(15)
root.right?.right = TreeNode(7)

print(Solution().levelOrder(root))
