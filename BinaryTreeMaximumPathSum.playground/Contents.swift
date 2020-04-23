/**
 Given a non-empty binary tree, find the maximum path sum.

 For this problem, a path is defined as any sequence of nodes from some starting node to any node in the
 tree along the parent-child connections.
 The path must contain at least one node and does not need to go through the root.

     Example 1:
     Input: [1,2,3]

                1
               / \
              2   3

     Output: 6

     Example 2:
     Input: [-10,9,20,null,null,15,7]

            -10
            / \
           9  20
             /  \
            15   7

     Output: 42
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
     - Complexity: O(n) where n is the number of nodes. O(h) space for call stack space.
     */
    func maxPathSum(_ root: TreeNode?) -> Int {
        var maxSum = Int.min

        func maxGain(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }

            let leftGain = max(maxGain(node.left), 0)
            let rightGain = max(maxGain(node.right), 0)

            let potentialNewGain = node.val + leftGain + rightGain

            maxSum = max(maxSum, potentialNewGain)

            return node.val + max(leftGain, rightGain)
        }

        maxGain(root)
        return maxSum
    }
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)

let root2 = TreeNode(-10)
root2.left = TreeNode(9)
root2.right = TreeNode(20)
root2.right?.left = TreeNode(15)
root2.right?.right = TreeNode(7)

//print(Solution().maxPathSum(root))      // 6
print(Solution().maxPathSum(root2))     // 42
