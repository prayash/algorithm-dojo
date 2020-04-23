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
    func toSumTree(_ root: TreeNode?) -> Int {
        guard var node = root else { return 0 }

        let oldValue = node.val
        node.val = toSumTree(node.left) + toSumTree(node.right)

        return node.val + ol
    }
}

var root = TreeNode(10)
root.left = TreeNode(-2)
root.right = TreeNode(6)
root.left?.left = TreeNode(8)
root.left?.right = TreeNode(-4)
root.right?.left = TreeNode(7)
root.right?.right = TreeNode(5)

print(Solution().toSumTree(root))
