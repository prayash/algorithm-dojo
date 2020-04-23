/**
 Given the root of a binary search tree with distinct values, modify it so that every
 node has a new value equal to the sum of the values of the original tree that
 are greater than or equal to node.val.
 */

public class TreeNode {
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
    func bstToGst(_ root: TreeNode?) -> TreeNode? {
        guard root != nil else { return nil }
        bstToGst(root, 0)
        return root
    }

    private func bstToGst(_ root: TreeNode?, _ counter: Int) -> Int {
        guard let root = root else { return counter }

        root.val = bstToGst(root.right, counter) + root.val
        return bstToGst(root.left, root.val)
    }

    private func bstToGstIteratice(_ root: TreeNode?) -> TreeNode? {
        var sum = 0
        let newRoot = root
        var currentNode = root
        var stack: [TreeNode] = []

        while !stack.isEmpty || currentNode != nil {
            while currentNode != nil {
                stack.append(currentNode!)
                currentNode = currentNode!.right
            }

            currentNode = stack.removeLast()
            currentNode!.val += sum
            sum = currentNode!.val
            currentNode = currentNode!.left
        }

        return newRoot
    }
}
