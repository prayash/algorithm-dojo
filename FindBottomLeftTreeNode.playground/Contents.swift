/**
 Given a binary tree, find the leftmost value in the last row of the tree.
 Input:

         1
        / \
       2   3
      /   / \
     4   5   6
        /
       7

 Output:
     7
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
     Do a BFS traversal from right to left, overwriting the result value with the last seen
     node, which will always be the leftmost node. O(n) time and space.
     */
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return -1
        }

        var bfsQueue: [TreeNode] = [root]
        var result = 0

        while !bfsQueue.isEmpty {
            let node = bfsQueue.removeFirst()

            if node.right != nil {
                bfsQueue.append(node.right!)
            }

            if node.left != nil {
                bfsQueue.append(node.left!)
            }

            result = node.val
        }

        return result
    }
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left?.left = TreeNode(4)
root.right?.left = TreeNode(5)
root.right?.right = TreeNode(6)
root.right?.left?.left = TreeNode(7)

print(Solution().findBottomLeftValue(root))
