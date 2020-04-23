/**
 Given the root node of a binary search tree (BST) and a value to be inserted into the
 tree, insert the value into the BST. Return the root node of the BST after the insertion.
 It is guaranteed that the new value does not exist in the original BST.

 Note that there may exist multiple valid ways for the insertion, as long as the tree remains
 a BST after insertion. You can return any of them.

 Given the tree:
         4
        / \
       2   7
      / \
     1   3
 And the value to insert: 5
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
     Recursive approach.
     - Complexity: O(H) where H is tree height. O(log n) in average case, O(n) in worst case.
     */
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let node = root else { return TreeNode(val) }

        if node.val > val {
            node.left = insertIntoBST(node.left, val)
        } else if node.val < val {
            node.right = insertIntoBST(node.right, val)
        }

        return node
    }

    func insertIntoBSTIterative(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else {
            return TreeNode(val)
        }

        var n = root
        while n.val != val {
            if n.val > val {
                if n.left == nil {
                    n.left = TreeNode(val)
                }
                n = n.left!
            } else {
                if n.right == nil {
                    n.right = TreeNode(val)
                }
                n = n.right!
            }
        }

        return root
    }
}

let root = TreeNode(4)
root.left = TreeNode(2)
root.right = TreeNode(7)
root.left?.left = TreeNode(1)
root.left?.right = TreeNode(3)

print(Solution().insertIntoBST(root, 5)?.val)
