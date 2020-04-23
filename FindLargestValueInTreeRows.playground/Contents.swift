/**
 You need to find the largest value in each row of a binary tree.

         1
        / \
       3   2
      / \   \
     5   3   9

 Output: [1, 3, 9]
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
    // BFS with O(n) time and space.
    // Just move across level-order and record the max number seen
    func largestValues(_ root: TreeNode?) -> [Int] {
        guard let root = root else {
            return []
        }

        var result: [Int] = []
        var bfsQueue: [TreeNode] = [root]

        while !bfsQueue.isEmpty {
            var maxAtLevel = Int.min

            for _ in 0..<bfsQueue.count {
                let node = bfsQueue.removeFirst()

                if let left = node.left {
                    bfsQueue.append(left)
                }

                if let right = node.right {
                    bfsQueue.append(right)
                }

                maxAtLevel = max(node.val, maxAtLevel)
            }

            result.append(maxAtLevel)
        }

        return result
    }
}


let root = TreeNode(1)
root.left = TreeNode(3)
root.right = TreeNode(2)
root.left?.left = TreeNode(5)
root.left?.right = TreeNode(3)
root.right?.right = TreeNode(9)

print(Solution().largestValues(root))
