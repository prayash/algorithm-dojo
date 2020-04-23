/**
 Given a binary tree, find its maximum depth.
 The maximum depth is the number of nodes along the longest path from the root node
 down to the farthest leaf node.
 Note: A leaf is a node with no children.

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
    // DFS Recursion. Beware of stack overflow.
    // O(n) time where n is number of nodes.
    func maxDepthDFS(_ root: TreeNode?) -> Int {
        guard let node = root else {
            return 0
        }

        return max(maxDepthDFS(node.left), maxDepthDFS(node.right)) + 1
    }

    func maxDepth(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }

        var stack: [TreeNode] = [node]
        var depth = 0

        while !stack.isEmpty {
            depth += 1

            for _ in 0..<stack.count {
                let n = stack.removeFirst()
                print(n.val)

                if n.left != nil {
                    stack.append(n.left!)
                }

                if n.right != nil {
                    stack.append(n.right!)
                }
            }
        }

        return depth
    }

    func maxDepthBFS(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }

        var queue: [TreeNode] = [node]
        var depth = 0

        while !queue.isEmpty {
            depth += 1

            for _ in 0..<queue.count {
                let n = queue.removeFirst()

                if n.left != nil {
                    queue.append(n.left!)
                }

                if n.right != nil {
                    queue.append(n.right!)
                }
            }
        }

        return depth
    }
}

let root = TreeNode(3)
root.left = TreeNode(9)
root.right = TreeNode(20)
root.right?.left = TreeNode(15)
root.right?.right = TreeNode(7)

print(Solution().maxDepth(root))
