/**
 Given two binary trees and imagine that when you put one of them to cover
 the other, some nodes of the two trees are overlapped while the others are not.

 You need to merge them into a new binary tree. The merge rule is that if two
 nodes overlap, then sum node values up as the new value of the merged node.
 Otherwise, the NOT null node will be used as the node of new tree.

 Input:
     Tree 1                     Tree 2
           1                         2
          / \                       / \
         3   2                     1   3
        /                           \   \
       5                             4   7
 Output:
 Merged tree:
          3
         / \
        4   5
       / \   \
      5   4   7
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
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        guard let a = t1 else {
            return t2
        }

        guard let b = t2 else {
            return t1
        }

        let node = TreeNode(a.val + b.val)
        let left = mergeTrees(a.left, b.left)
        let right = mergeTrees(a.right, b.right)

        node.left = left
        node.right = right

        return node
    }
}

let a = TreeNode(1)
a.left = TreeNode(3)
a.left?.left = TreeNode(5)
a.right = TreeNode(2)

let b = TreeNode(2)
b.left = TreeNode(1)
b.left?.right = TreeNode(4)
b.right = TreeNode(3)
b.right?.right = TreeNode(7)

print(Solution().mergeTrees(a, b)!.val)
