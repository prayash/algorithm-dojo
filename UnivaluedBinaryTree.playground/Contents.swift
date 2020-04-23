/**
 A binary tree is univalued if every node in the tree has the same value.
 Return true if and only if the given tree is univalued.

 Input: [1,1,1,1,1,null,1]
 Output: true
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
     Recursively check all children passing the root node's value for assertion.
     O(n) time where n is all the nodes in the tree
     */
    func isUnivalTree(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }

        func helper(_ node: TreeNode?, _ unival: Int) -> Bool {
            guard let node = node else { return true }

            if node.val != unival {
                return false
            }

            let isLeftUnivalued = helper(node.left, unival)
            let isRightUnivalued = helper(node.right, unival)

            return isLeftUnivalued && isRightUnivalued
        }

        return helper(root, root.val)
    }
}

var root = TreeNode(1)
root.left = TreeNode(1)
root.left?.left = TreeNode(1)
root.left?.right = TreeNode(1)
root.right = TreeNode(1)
root.right?.right = TreeNode(1)

print(Solution().isUnivalTree(root))

let root2 = TreeNode(2)
root2.left = TreeNode(2)
root2.left?.left = TreeNode(5)
root2.left?.right = TreeNode(2)
root2.right = TreeNode(2)

print(Solution().isUnivalTree(root2))
