/**
 For a binary tree T, we can define a flip operation as follows: choose any node, and swap
 the left and right child subtrees.
 A binary tree X is flip equivalent to a binary tree Y if and only if we can make X equal to Y after
 some number of flip operations.
 Write a function that determines whether two binary trees are flip equivalent.  The trees are given
 by root nodes root1 and root2.
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
    // Recursive DFS: O(min(n1, n2)) time and O(min(h1, h2)) space
    func flipEquiv(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        if root1 == nil && root2 == nil {
            return true
        }

        if root1 == nil || root2 == nil || root1?.val != root2?.val {
            return false
        }

        return flipEquiv(root1?.left, root2?.left) && flipEquiv(root1?.right, root2?.right) ||
            flipEquiv(root1?.left, root2?.right) && flipEquiv(root1?.right, root2?.left)
    }
}
