/**
 Given the root node of a binary search tree (BST) and a value. You need to
 find the node in the BST that the node's value equals the given value. Return
 the subtree rooted with that node. If such node doesn't exist, you should
 return NULL.

 For example,

 Given the tree:
         4
        / \
       2   7
      / \
     1   3

 And the value to search: 2
 You should return this subtree:

       2
      / \
     1   3
 In the example above, if we want to search the value 5, since there is no
 node with value 5, we should return NULL.

 Note that an empty tree is represented by NULL, therefore you would see the
 expected output (serialized tree format) as [], not null.
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
     Binary search on a BST.
     - Complexity: O(h) where h is tree height. O(log n) average, O(n) worse case. O(h) for recursion call stack.
     */
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let node = root else {
            return nil
        }

        if node.val > val {
            return searchBST(node.left, val)
        } else if node.val < val {
            return searchBST(node.right, val)
        } else {
            return node
        }
    }
}

let root = TreeNode(4)
root.left = TreeNode(2)
root.right = TreeNode(7)
root.left?.left = TreeNode(1)
root.left?.right = TreeNode(3)

print(Solution().searchBST(root, 2))
