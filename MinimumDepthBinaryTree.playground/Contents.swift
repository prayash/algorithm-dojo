/**
 Given a binary tree, find its minimum depth.
 The minimum depth is the number of nodes along the shortest path from the root node down to
 the nearest leaf node.
 Note: A leaf is a node with no children.

 Given binary tree [3,9,20,null,null,15,7], return its minimum depth = 2.

           3
          / \
         9  20
           /  \
          15   7
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
    func minDepthRecursive(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }

        if root.left == nil && root.right == nil {
            return 1
        }

        var minDepth = Int.max

        if root.left != nil {
            minDepth = min(minDepth, minDepthRecursive(root.left!))
        }

        if root.right != nil {
            minDepth = min(minDepth, minDepthRecursive(root.right!))
        }

        return minDepth + 1
    }

    /**
     For a DFS traversal, all nodes are visited before we can calculate the minimum,
     so worst-case time is O(n). O(n) space because we'll keep the entire tree.
     */
    func minDepthDFS(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }

        var nodeStack: [TreeNode] = [root]
        var depthStack: [Int] = [1]
        var minDepth = Int.max

        while !nodeStack.isEmpty {
            let node = nodeStack.removeLast()
            let currentDepth = depthStack.removeLast()

            // If it's a leaf node, we'll update our minDepth
            if node.left == nil && node.right == nil {
                minDepth = min(minDepth, currentDepth)
            }

            if node.left != nil {
                nodeStack.append(node.left!)
                depthStack.append(currentDepth + 1)
            }

            if node.right != nil {
                nodeStack.append(node.right!)
                depthStack.append(currentDepth + 1)
            }

        }

        return minDepth
    }

    /**
     Iterate the tree level by level using BFS traversal. The optimization here is that we
     can terminate right when we find a leaf node. Worst case, we'll need to visit all
     nodes level by level for a balanced tree, so O(n) time and O(n) space. Best-case, we'll
     do n / 2 nodes (exluding the last level).
     */
    func minDepthBFS(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }

        var queue: [TreeNode] = [root]
        var depth = 0

        while !queue.isEmpty {
            depth += 1

            for _ in 0..<queue.count {
                let node = queue.removeFirst()

                // If it's a leaf node, we'll terminate
                if node.left == nil && node.right == nil {
                    return depth
                }

                // Progressively add child nodes to the queue
                if node.left != nil {
                    queue.append(node.left!)
                }

                if node.right != nil {
                    queue.append(node.right!)
                }
            }
        }

        return -1
    }
}

let root = TreeNode(3)
root.left = TreeNode(9)
root.right = TreeNode(20)
root.right?.left = TreeNode(15)
root.right?.right = TreeNode(7)

print(Solution().minDepthDFS(root))

let root2 = TreeNode(0)
print(Solution().minDepthDFS(root2))
