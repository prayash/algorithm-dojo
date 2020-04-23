/**
 Given the root of a binary tree, each node has a value from 0 to 25 representing the
 letters 'a' to 'z': a value of 0 represents 'a', a value of 1 represents 'b', and so on.
 Find the lexicographically smallest string that starts at a leaf of this tree and ends at the root.

 (As a reminder, any shorter prefix of a string is lexicographically smaller:
 for example, "ab" is lexicographically smaller than "aba".  A leaf of a node is a
 node that has no children.)

 Input: [0,1,2,3,4,3,4]
 Output: "dba"
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
    var map = [Int: String]()
    func smallestFromLeaf(_ root: TreeNode?) -> String {
        var n = 0
        "abcdefghijklmnopqrstuvwxyz".forEach { map[n] = String($0); n += 1 }
        return postTraverseTree(root, "")
    }

    func postTraverseTree(_ root: TreeNode?, _ str: String) -> String {
        if root == nil {
            return str
        }

        let curStr = map[root!.val]! + str

        if root!.left != nil && root!.right != nil {
            let left = postTraverseTree(root!.left, curStr)
            let right = postTraverseTree(root!.right, curStr)
            return left < right ? left : right
        }
        else if root!.left != nil {
            return postTraverseTree(root!.left, curStr)
        }
        else if root!.right != nil {
            return postTraverseTree(root!.right, curStr)
        }
        else {
            return curStr
        }
    }
}

let root = TreeNode(0)
root.left = TreeNode(1)
root.right = TreeNode(2)
root.left?.left = TreeNode(3)
root.left?.right = TreeNode(4)
root.right?.left = TreeNode(3)
root.right?.right = TreeNode(4)

print(Solution().smallestFromLeaf(root))
