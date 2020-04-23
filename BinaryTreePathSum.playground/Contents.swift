/**
 Given a binary tree and a sum, determine if the tree has a root-to-leaf path such that
 adding up all the values along the path equals the given sum.
 Note: A leaf is a node with no children.

     // Given the below binary tree and sum = 22,

           5
          / \
         4   8
        /   / \
       11  13  4
      /  \      \
     7    2      1

     // return true, as there exist a root-to-leaf path 5->4->11->2 which sum is 22.
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
     Similar to the SumRootToLeafNumbers problem, we'll terminate DFS based on an encounter
     with a leaf node.
     - Complexity: O(n) because we have to process every node. O(n) space for recursion call stack
     in case the tree is unbalanced. If balanced, best case space complexity would be O(log n).
     */
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        guard let node = root else { return false }

        let newSum = sum - node.val
        let isLeafNode = node.left == nil && node.right == nil

        if isLeafNode {
            return newSum == 0
        }

        let hasPathSumLeft = hasPathSum(node.left, newSum)
        let hasPathSumRight = hasPathSum(node.right, newSum)

        return hasPathSumLeft || hasPathSumRight
    }
}

let root = TreeNode(5)
root.left = TreeNode(4)
root.right = TreeNode(8)
root.right?.left = TreeNode(13)
root.right?.right = TreeNode(4)
root.right?.right?.right = TreeNode(1)
root.left?.left = TreeNode(11)
root.left?.left?.left = TreeNode(7)
root.left?.left?.right = TreeNode(2)

print(Solution().hasPathSum(root, 22))
