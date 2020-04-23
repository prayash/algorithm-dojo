/**
 Given a binary tree, determine if it is height-balanced.
 For this problem, a height-balanced binary tree is defined as:
 A binary tree in which the left and right subtrees of every node differ in height by no more than 1.

 Given the following tree [3,9,20,null,null,15,7]:

         3
        / \
       9  20
         /  \
        15   7
 Return true.

 Given the following tree [1,2,2,3,3,null,null,4,4]:

            1
           / \
          2   2
         / \
        3   3
       / \
      4   4

 Return false.
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
     Top-down approach: Lots of repetitive work, because we calculate the height over and over
     while accessing all nodes in the tree. For each node in the tree, we have to access all
     of its children.
     - Complexity: O(n log n) for total scan of N nodes, with log n levels.
     */
    func isBalancedTopDown(_ root: TreeNode?) -> Bool {
        func height(_ node: TreeNode?) -> Int {
            guard let node = node else {
                return 0
            }

            return max(height(node.left), height(node.right)) + 1
        }

        guard let root = root else {
            return true
        }

        if abs(height(root.left) - height(root.right)) > 1 {
            return false
        }

        return isBalancedTopDown(root.left) && isBalancedTopDown(root.right)
    }

    /**
     Bottom-up approach: Recursively calculate by building up call-stack. When the sub-tree
     of the current node is balanced, we return a non-negative value. Each node in the tree
     only needs to be accessed once.
     - Complexity: O(n) time because we might touch all nodes in the tree,
     but if it's unbalanced then we'll save time. O(h) space for callstack
     population from the height of the tree.
     */
    func isBalanced(_ root: TreeNode?) -> Bool {
        func height(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }

            let leftHeight = height(node.left)
            let rightHeight = height(node.right)
            let heightDiff = abs(leftHeight - rightHeight)

            if leftHeight == -1 || rightHeight == -1 || heightDiff > 1 {
                return -1
            }

            return max(leftHeight, rightHeight) + 1
        }

        return height(root) != -1
    }
}

let root = TreeNode(3)
root.left = TreeNode(9)
root.right = TreeNode(20)
root.right?.left = TreeNode(15)
root.right?.right = TreeNode(7)

print(Solution().isBalanced(root))
