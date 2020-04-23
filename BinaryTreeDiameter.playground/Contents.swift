/**
 Given a binary tree, you need to compute the length of the diameter of the tree. The diameter
 of a binary tree is the length of the longest path between any two nodes in a tree. This path
 may or may not pass through the root.

             1
            / \
           2   3
          / \
         4   5

    Return 3, which is the length of the path [4,2,1,3] or [5,2,1,3].
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
     The diameter of a binary tree is the height of the left subtree + right subtree.
     */
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var diameter = 0

        func depth(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }

            let left = depth(node.left)
            let right = depth(node.right)

            diameter = max(diameter, left + right)

            return max(left, right) + 1
        }

        depth(root)
        return diameter
    }
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left?.left = TreeNode(4)
root.left?.right = TreeNode(5)

print(Solution().diameterOfBinaryTree(root))
