/**
 Given the root node of a binary search tree, return the sum of values of all nodes with
 value between L and R (inclusive).
 The binary search tree is guaranteed to have unique values.

 Input: root = [10,5,15,3,7,null,18], L = 7, R = 15
 Output: 32

 Input: root = [10,5,15,3,7,13,18,1,null,6], L = 6, R = 10
 Output: 23
 */

class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    /**
     DFS recursion with a few conditionals.
     - Complexity: O(n) for all nodes have to be processed. O(h) space for recursion.
     */
    func rangeSumBST(_ root: Node?, _ L: Int, _ R: Int) -> Int {
        guard let node = root else { return 0 }

        let nodeVal = node.val < L || node.val > R ? 0 : node.val
        let leftRangeSum = rangeSumBST(node.left, L, R)
        let rightRangeSum = rangeSumBST(node.right, L, R)

        return leftRangeSum + rightRangeSum + nodeVal
    }
}

let root = Node(10)
root.left = Node(5)
root.right = Node(15)
root.left?.left = Node(3)
root.left?.right = Node(7)
root.right?.right = Node(18)

print(Solution().rangeSumBST(root, 7, 15))
