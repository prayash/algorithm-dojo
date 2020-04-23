/**
 Given a non-empty binary search tree and a target value, find the value in the BST that
 is closest to the target. Given target value is a floating point.
 You are guaranteed to have only one unique value in the BST that is closest to the target.

     Input: root = [4,2,5,1,3], target = 3.714286

             4
            / \
           2   5
          / \
         1   3

     Output: 4
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
    // Recursive Inorder + Linear search, O(n) time + space
    func closestValue(_ root: TreeNode?, _ target: Double) -> Int {
        func inorderTraverse(_ node: TreeNode?, _ nums: inout [Double]) {
            guard let node = node else { return }

            inorderTraverse(node.left, &nums)
            nums.append(Double(node.val))
            inorderTraverse(node.right, &nums)
        }

        var numsSorted = [Double]()
        inorderTraverse(root, &numsSorted)

        return Int(numsSorted.reduce(numsSorted[0]) {
            abs($0 - target) < abs($1 - target) ? $0 : $1
        })
    }

    // Binary search: O(h) time because it goes from the root down to the leaf. O(1) space.
    func closestValueBS(_ root: TreeNode?, _ target: Double) -> Int {
        var val: Double = 0
        var closest: Double = Double(root!.val)
        var node = root

        while node != nil {
            val = Double(node!.val)
            closest = abs(val - target) < abs(closest - target) ? val : closest
            node = target < val ? node!.left : node!.right
        }

        return Int(closest)
    }
}

var root = TreeNode(4)
root.left = TreeNode(2)
root.right = TreeNode(5)
root.left?.left = TreeNode(1)
root.left?.right = TreeNode(3)

print(Solution().closestValueBS(root, 3.714286))
