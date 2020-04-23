/**
 Given a binary tree, determine if it is a valid binary search tree (BST).
 Assume a BST is defined as follows:
 The left subtree of a node contains only nodes with keys less than the node's key.
 The right subtree of a node contains only nodes with keys greater than the node's key.
 Both the left and right subtrees must also be binary search trees.

     2
    / \
   1   3

 Input: [2, 1, 3]
 Output: true

     5
    / \
   1   4
      / \
     3   6

 Input: [5,1,4,null,null,3,6]
 Output: false
 Explanation: The root node's value is 5 but its right child's value is 4.
 https://leetcode.com/problems/validate-binary-search-tree/discuss/32112/Learn-one-iterative-inorder-traversal-apply-it-to-multiple-tree-questions-(Java-Solution)
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
     In order traversal (DFS).
     O(n) in the worst case when the tree is BST or the "bad" element is a rightmost leaf.
     O(n) space to keep a stack.
     */
    func isValidBST(_ root: TreeNode?) -> Bool {
        var node = root
        var stack = [TreeNode]()
        var pre: TreeNode?
        var list = [Int]()

        while node != nil || !stack.isEmpty {
            // Throw the node onto a stack and traverse leftwards
            if node != nil {
                stack.append(node!)
                node = node!.left
            } else {
                node = stack.popLast()

                // If next element in inorder traversal
                // is smaller than the previous one
                // it's not a valid BST.
                if pre != nil && node!.val <= pre!.val {
                    print(list)
                    return false
                }

                pre = node

                // If this list isn't sorted during inorder traversal, BST is invalid as well
                list.append(node!.val)

                node = node!.right
            }
        }

        print(list)

        return true
    }
}

var root = TreeNode(5)
root.left = TreeNode(1)
root.right = TreeNode(4)
root.right?.right = TreeNode(6)
root.right?.left = TreeNode(3)

print(Solution().isValidBST(root))

root = TreeNode(2)
root.left = TreeNode(1)
root.right = TreeNode(3)

print(Solution().isValidBST(root))

root = TreeNode(4)
root.left = TreeNode(2)
root.right = TreeNode(5)
root.left?.left = TreeNode(1)
root.left?.right = TreeNode(6)

print(Solution().isValidBST(root))
