/**
 Given a non-empty binary tree, return the average value of the nodes on each level in the
 form of an array.
 Example 1:
 Input:
     3
    / \
   9  20
     /  \
    15   7
 Output: [3, 14.5, 11]
 Explanation:
 The average value of nodes on level 0 is 3,  on level 1 is 14.5, and on level 2 is 11.
 Hence return [3, 14.5, 11].
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
     Use BFS to sum up every level and append the average at the end of each level traversal.
     - Complexity: O(n) time and space to process each node.
     */
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let root = root else { return [] }

        var result = [Double]()
        var bfsQueue: [TreeNode] = [root]

        while !bfsQueue.isEmpty {
            let size = Double(bfsQueue.count)
            var sum: Double = 0

            for _ in 0..<Int(size) {
                let node = bfsQueue.removeFirst()

                sum += Double(node.val)

                if let left = node.left {
                    bfsQueue.append(left)
                }

                if let right = node.right {
                    bfsQueue.append(right)
                }
            }

            result.append(sum / size)
        }

        return result
    }
}

let root = TreeNode(3)
root.left = TreeNode(9)
root.right = TreeNode(20)
root.right?.left = TreeNode(15)
root.right?.right = TreeNode(7)

print(Solution().averageOfLevels(root))
