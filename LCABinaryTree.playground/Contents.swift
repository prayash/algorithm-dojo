/**
 Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

 According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

 Given the following binary tree:  root = [3,5,1,6,2,0,8,null,null,7,4]

 Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
 Output: 3
 Explanation: The LCA of nodes 5 and 1 is 3.
 */

class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?

    public init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}


extension TreeNode: Equatable {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
}

class Solution {
    /**
     Time-complexity: O(h) where h is the height of the BST.
     Space-complexity: O(h)
     */
    func findLCA(_ root: TreeNode?, _ left: TreeNode?, _ right: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }

        if root == left || root == right {
            return root
        }

        let left = findLCA(root?.left, left, right)
        let right = findLCA(root?.right, left, right)

        // if left is at a leaf, try to go right
        // NOTE: right might be nil, let the base condition handle it
        if left == nil {
            return right
        }

        // if right is at a leaf, try to go left
        // NOTE: left might be nil, let the base condition handle it
        if right == nil {
            return left
        }

        // Both left and right are NOT nil.
        // We have some common node that is not left or right
        return root
    }
}


var root = TreeNode(3, TreeNode(5,
                             TreeNode(6),
                             TreeNode(2, TreeNode(7), TreeNode(4))),
                    TreeNode(1, TreeNode(0), TreeNode(8)))

print(Solution().findLCA(root, TreeNode(5), TreeNode(1))!.val)
print(Solution().findLCA(root, TreeNode(5), TreeNode(4))!.val)
print(Solution().findLCA(root, TreeNode(7), TreeNode(4))!.val)

var r = TreeNode(3)
r.left = TreeNode(2)
r.left?.left = TreeNode(1)
r.left?.right = TreeNode(2)
r.right = TreeNode(5)
r.right?.left = TreeNode(4)
r.right?.right = TreeNode(7)

print(Solution().findLCA(r, TreeNode(1), TreeNode(7))?.val)
