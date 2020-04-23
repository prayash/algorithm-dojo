/**
 Given two non-empty binary trees s and t, check whether tree t has exactly the same structure and
 node values with a subtree of s. A subtree of s is a tree consists of a node in s and all of this
 node's descendants. The tree s could also be considered as a subtree of itself.

 Example 1:
 Given tree s:

      3
     / \
    4   5
   / \
  1   2

 Given tree t:
    4
   / \
  1   2
 Return true, because t has the same structure and node values with a subtree of s.
 */

public class TreeNode {
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
    func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        return s != nil && (s?.val == t?.val || helper(s?.left, t) || helper(s?.right, t))
    }

    func helper(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        if s == nil && t == nil {
            return true
        }

        if s == nil || t == nil {
            return false
        }

        let isLeftSubtree = isSubtree(s!.left, t!.left)
        let isRightSubtree = isSubtree(s!.right, t!.right)

        return s!.val == t!.val && isLeftSubtree && isRightSubtree
    }
}

let root = TreeNode(3)
root.left = TreeNode(4)
root.right = TreeNode(5)
root.left?.left = TreeNode(1)
root.left?.right = TreeNode(2)

let subRoot = TreeNode(4)
subRoot.left = TreeNode(1)
subRoot.right = TreeNode(2)

print(Solution().isSubtree(root, subRoot))
