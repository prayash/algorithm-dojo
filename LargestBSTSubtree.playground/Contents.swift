/**
 Given a binary tree, find the largest subtree which is a Binary Search Tree (BST),
 where largest means subtree with largest number of nodes in it.
 Can you figure out ways to solve it with O(n) time complexity?

 Note:
 A subtree must include all of its descendants.

 Input: [10,5,15,1,8,null,7]

    10
    / \
   5  15
  / \   \
 1   8   7

 Output: 3
 Explanation: The Largest BST Subtree in this case is the 5 -> [1, 8].
              The return value is the subtree's size, which is 3.
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
struct Result {
    var isBST = false
    var size = 0
    var min = 0
    var max = 0
}

class Solution {
    func largestBSTSubtree(_ root: TreeNode?) -> Int {
        return bst(root).size
    }

    /**
     Traverse tree in post-order fashion. L & R nodes return 4 pieces
     of information to root. If both L & R subtree are BST, and the current
     node data is greater than max of L and less than R, then it returns to the above level with updated min and max values.
     */
    func bst(_ node: TreeNode?) -> Result {
        guard node != nil else {
            return Result(isBST: true, size: 0, min: Int.max, max: Int.min)
        }

        // Post-order traversal. Visit L, R, then use that info
        // to calculate largest BST.
        let left = bst(node?.left)
        let right = bst(node?.right)

        // Current node wants to be part (i.e. root) of a BST, it must satisfy:
        // 1. its left subtree is a bst
        // 2. its right subtree is a bst
        // 3. its value > max value of its left subtree
        // 4. its value <= min value of its right subtree
        if left.isBST, right.isBST, node!.val > left.max, node!.val <= right.min {
            // If current node happens to satisfy all above requirements
            // We will return a new result for subtree rooting from current node with:
            // true --- tree rooting from current node is a valid BST
            // total size of subtree rooting from current node
            // min value of the new BST
            // max value of the new BST
            let minOfBST = min(node!.val, left.min)
            let maxOfBST = max(node!.val, right.max)
            let sizeOfBST = left.size + right.size + 1

            return Result(isBST: true, size: sizeOfBST, min: minOfBST, max: maxOfBST)
        } else {
            // If current node does not satisfy all above requirements,
            // the whole tree from current node will be invalidated
            // HOWEVER, its left and/or right child may still be root of a valid BST,
            // So we need to carry over the max of their sizes in order to return it to top level.
            return Result(isBST: false, size: max(left.size, right.size), min: 0, max: 0)
        }
    }
}

var root = TreeNode(10)
root.left = TreeNode(5)
root.left?.left = TreeNode(1)
root.left?.right = TreeNode(8)
root.right = TreeNode(15)
root.right?.right = TreeNode(7)

root = TreeNode(35)
root.left = TreeNode(20)
root.right = TreeNode(40)

print(Solution().largestBSTSubtree(root))
