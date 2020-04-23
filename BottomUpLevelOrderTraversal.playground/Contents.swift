/**
 Given a binary tree, return the bottom-up level order traversal of its nodes' values.
 (ie, from left to right, level by level from leaf to root).

 For example:
 Given binary tree [3,9,20,null,null,15,7]

       3
      / \
     9  20
       /  \
      15   7

 return:

     [
       [15,7],
       [9,20],
       [3]
     ]
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
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }

        var result: [[Int]] = []
        var queue: [TreeNode] = [root]

        while !queue.isEmpty {
            var levelNodes = [Int]()

            for _ in 0..<queue.count {
                let node = queue.removeFirst()

                if let left = node.left {
                    queue.append(left)
                }

                if let right = node.right {
                    queue.append(right)
                }

                levelNodes.append(node.val)
            }

            result.append(levelNodes)
        }

        return result.reversed()
    }
}

let root = TreeNode(3)
root.left = TreeNode(9)
root.right = TreeNode(20)
root.right?.left = TreeNode(15)
root.right?.right = TreeNode(7)

print(Solution().levelOrderBottom(root))
