/**
 Given a complete binary tree, count the number of nodes.

 Note:
 In a complete binary tree every level, except possibly the last, is completely filled,
 and all nodes in the last level are as far left as possible. It can have
 between 1 and 2h nodes inclusive at the last level h.


 Input:
      1
    /   \
   2     3
  / \   /
 4   5 6

 Output: 6
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
     Naive solution here is to traverse the entire tree and count bottom-up. This does not
     leverage the fact that the tree is a complete tree!
     - Complexity: O(n) time to process all nodes. O(d) = O(log n) to keep recursion stack where d is depth.
     */
    func countNodesRecursive(_ root: TreeNode?) -> Int {
        // Base case
        if root == nil {
            return 0
        }

        // Recursively count children + 1 for the current node we're on.
        return countNodes(root?.left) + countNodes(root?.right) + 1
    }

    /**
     A complete binary tree has at `2 ^ (d - 1)` nodes at all levels, except the last one which could be
     anywhere between `1` and `2 ^ (d - 1)`. Knowing this, we can compute the number of nodes in all
     levels but the last one, so this reduces the problem to a simple check of how many nodes the tree
     has on the last level.
     - Complexity: O(d ^ 2) = O(log ^ 2 n) where d is tree depth. O(1) space.
     */
    func countNodes(_ root: TreeNode?) -> Int {
        guard let node = root else { return 0 }

        let depth = computeDepth(node)
        guard depth > 0 else { return 1 }

        // Last level nodes are enumerated from 0 to 2 ^ d - 1 (left -> right).
        // Perform binary search to check how many nodes exist.
        let topLevelNodeCount = 2 << (depth - 1) - 1
        var low = 1
        var high = topLevelNodeCount
        while low <= high {
            let mid = low + (high - low) / 2
            let nodeExists = exists(mid, depth, node)

//            print("\(mid) exists? \(nodeExists)")

            // Enumerate potential nodes in the last level from 0 to 2 ^ d - 1
            // until we hit a node that doesn't exist!
            if nodeExists {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }

        // The tree contains 2 ^ d - 1 nodes on the first (d - 1) levels
        // and left nodes on the last level.
        return topLevelNodeCount + low
    }

    func exists(_ index: Int, _ depth: Int, _ node: TreeNode) -> Bool {
        var node: TreeNode? = node
        let numNodes = 2 << (depth - 1) - 1
        var left = 0
        var right = numNodes

        for _ in 0..<depth {
            let pivot = left + (right - left) / 2

            if index <= pivot {
                node = node?.left
                right = pivot
            } else {
                node = node?.right
                left = pivot + 1
            }
        }

        return node != nil
    }

    func computeDepth(_ node: TreeNode?) -> Int {
        guard var node = node else { return 0 }
        var count = 0

        while node.left != nil {
            node = node.left!
            count += 1
        }

        return count
    }
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left?.left = TreeNode(4)
root.left?.right = TreeNode(5)
root.right?.left = TreeNode(6)

//print("Number of nodes: \(Solution().countNodes(root))")
//print("Depth: \(Solution().computeDepth(root))")
//print(Solution().exists(3, 2, root))


let root2 = TreeNode(1)
root2.left = TreeNode(2)
root2.right = TreeNode(3)
print("Number of nodes: \(Solution().countNodes(root2))")
