/**
 Given a binary tree containing digits from 0-9 only, each root-to-leaf path could represent a number.
 An example is the root-to-leaf path 1->2->3 which represents the number 123.
 Find the total sum of all root-to-leaf numbers.
 Note: A leaf is a node with no children.

 Input: [1,2,3]
     1
    / \
   2   3
 Output: 25
 Explanation:
 The root-to-leaf path 1->2 represents the number 12.
 The root-to-leaf path 1->3 represents the number 13.
 Therefore, sum = 12 + 13 = 25.
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
    func sumNumbers(_ root: TreeNode?) -> Int {
        return dfs(root, 0)
    }

    private func dfs(_ node: TreeNode?, _ currentSum: Int) -> Int {
        guard let node = node else { return 0 }

        let isLeafNode = node.left == nil && node.right == nil
        let currentSum = currentSum * 10 + node.val

        if isLeafNode {
            return currentSum
        }

        let leftSum = dfs(node.left, currentSum)
        let rightSum = dfs(node.right, currentSum)

        return leftSum + rightSum
    }
}

let root = TreeNode(4)
root.left = TreeNode(9)
root.right = TreeNode(0)
root.left?.left = TreeNode(5)
root.left?.right = TreeNode(1)
print(Solution().sumNumbers(root)) // 1026

let root2 = TreeNode(1)
root2.left = TreeNode(2)
root2.right = TreeNode(3)
print(Solution().sumNumbers(root2)) // 25
