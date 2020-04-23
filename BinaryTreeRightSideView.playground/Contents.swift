/**
 Given a binary tree, imagine yourself standing on the right side of it, return the
 values of the nodes you can see ordered from top to bottom.

         1          <---
        / \
       2   3        <---
        \   \
         5   4      <---

 Output: [1, 3, 4]
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
    // O(n) time and space BFS traversal
    // For each level move from left to right, appending the final value to resulting list.
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root = root else {
            return []
        }

        var result: [Int] = []
        var queue: [TreeNode] = [root]

        while !queue.isEmpty {
            var rightSideValue = 0

            for _ in 0..<queue.count {
                let node = queue.removeFirst()

                if let left = node.left {
                    queue.append(left)
                }

                if let right = node.right {
                    queue.append(right)
                }

                rightSideValue = node.val
            }

            result.append(rightSideValue)
        }

        return result
    }

    func rightSideViewDFS(_ root: TreeNode?) -> [Int] {
        var result: [Int] = []
        guard let root = root else {
            return result
        }

        func dfsHelper(_ node: TreeNode?, level: Int) {
            guard let node = node else { return }

            // For each level, this will add the rightmost node
            if result.count == level {
                result.append(node.val)
            }

            dfsHelper(node.right, level: level + 1)
            dfsHelper(node.left, level: level + 1)
        }

        dfsHelper(root, level: 0)

        return result
    }
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left?.right = TreeNode(5)
root.right?.right = TreeNode(4)

print(Solution().rightSideViewDFS(root))
