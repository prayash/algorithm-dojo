/**
 Given a binary tree, return the postorder traversal of its nodes' values.

 Input: [1,null,2,3]
    1
     \
      2
     /
    3

 Output: [3,2,1]
 Follow up: Recursive solution is trivial, could you do it iteratively?
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
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        guard let root = root else { return res }
        var stack: [TreeNode] = [root]

        while !stack.isEmpty {
            let node = stack.removeLast()
            res.insert(node.val, at: 0)

            if let left = node.left {
                stack.append(left)
            }

            if let right = node.right {
                stack.append(right)
            }
        }

        return res
    }

    func postorderTraversalRecursive(_ root: TreeNode?) -> [Int] {
        var res = [Int]()
        dfs(root, &res)
        return res
    }

    private func dfs(_ root: TreeNode?, _ res: inout [Int]) {
        guard let node = root else {
            return
        }

        dfs(node.left, &res)
        dfs(node.right, &res)
        res.append(node.val)
    }
}

let root = TreeNode(1)
root.right = TreeNode(2)
root.right?.left = TreeNode(3)

print(Solution().postorderTraversal(root))
