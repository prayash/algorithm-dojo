/**
 Given a binary tree, return all root-to-leaf paths.
 Note: A leaf is a node with no children.
 Input:

        1
      /   \
     2     3
    / \
   5   9

 Output: ["1->2->5", "1->3"]
 Explanation: All root-to-leaf paths are: 1->2->5, 1->3
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
     - Complexity: O(n) time + space.
     */
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        guard let node = root else {
            return []
        }

        if node.left == nil && node.right == nil {
            return ["\(node.val)"]
        }

        let leftPaths = binaryTreePaths(node.left).map { "\(node.val)->\($0)" }
        let rightPaths = binaryTreePaths(node.right).map { "\(node.val)->\($0)" }

        return  leftPaths + rightPaths
    }
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left?.left = TreeNode(5)
root.left?.right = TreeNode(9)

print(Solution().binaryTreePaths(root))
