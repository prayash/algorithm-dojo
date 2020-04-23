/**
 In a binary tree, the root node is at depth 0, and children of each depth k node are at depth k+1.
 Two nodes of a binary tree are cousins if they have the same depth, but have different parents.

 We are given the root of a binary tree with unique values, and the values x and y of two
 different nodes in the tree.
 Return true if and only if the nodes corresponding to the values x and y are cousins.
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
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        guard let root = root else {
            return false
        }

        var depthMap: [Int : Int] = [:]
        var parentMap: [Int : TreeNode] = [:]
        var queue: [TreeNode] = [root]
        var level = 0

        while !queue.isEmpty {
            level += 1

            for _ in 0..<queue.count {
                let node = queue.removeFirst()

                depthMap[node.val] = level

                if let left = node.left {
                    parentMap[left.val] = node
                    queue.append(left)
                }

                if let right = node.right {
                    parentMap[right.val] = node
                    queue.append(right)
                }
            }
        }

        return depthMap[x] == depthMap[y] && parentMap[x] !==  parentMap[y]
    }
}

let root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left?.left = TreeNode(4)

print(Solution().isCousins(root, 3, 4))
