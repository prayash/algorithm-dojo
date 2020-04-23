/**
 Given an array where elements are sorted in ascending order, convert it to a height balanced BST.

 For this problem, a height-balanced binary tree is defined as a binary tree in which the depth
 of the two subtrees of every node never differ by more than 1.
 Given the sorted array: [-10,-3,0,5,9],
 One possible answer is: [0,-3,9,-10,null,5], which represents the following height balanced BST:

           0
          / \
        -3   9
        /   /
      -10  5
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
    // O(n) time since we visit each node exactly once.
    // O(n) space to keep the output.
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        func helper(_ left: Int, _ right: Int) -> TreeNode? {
            // If left > right, then there are no elements available for that subtree.
            if left > right {
                return nil
            }

            // Choose left middle node as a root
            let middleIndex = (left + right) / 2
            let root = TreeNode(nums[middleIndex])
            print(middleIndex)

            // Compute recursively left and right trees
            // Inorder traversal: left -> node -> right
            root.left = helper(left, middleIndex - 1)
            root.right = helper(middleIndex + 1, right)

            return root
        }

        return helper(0, nums.count - 1)
    }
}

print(Solution().sortedArrayToBST([-10,-3,0,5,9])!.val)
