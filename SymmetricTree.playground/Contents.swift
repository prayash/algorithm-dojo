/**
 Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).
 For example, this binary tree [1,2,2,3,4,4,3] is symmetric:

         1
        / \
       2   2
      / \ / \
     3  4 4  3

 But the following [1,2,2,null,3,null,3] is not:

           1
          / \
         2   2
          \   \
          3    3
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
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }

        var queue = [(left: root.left, right: root.right)]

        while !queue.isEmpty {
            let (left, right) = queue.removeFirst()

            if left == nil && right == nil {
                continue
            }

            if left == nil || right == nil {
                return false
            }

            if left?.val != right?.val {
                return false
            }

            queue.append((left: left?.left, right: right?.right))
            queue.append((left: left?.right, right: right?.left))
        }

        return true
    }
}
