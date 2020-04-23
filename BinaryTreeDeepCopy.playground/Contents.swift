/**
 Given a binary tree, write a function to create a deep copy of it.

 For example:
 Given binary tree [3, 9, 20, null, null, 15, 7]:
      3
     / \
    9  20
      /  \
     15   7

 Return a new tree with identical structure and nodes.
*/

protocol Copyable {
    func copy() -> Self
}

class Node<T: Comparable>: Copyable {
    public var val: T
    public var left: Node?
    public var right: Node?

    public init(_ val: T) {
        self.val = val
        self.left = nil
        self.right = nil
    }

    func copy() -> Self {
        return dfsCopy(self) as! Self
    }

    private func dfsCopy(_ root: Node?) -> Node? {
        guard let node = root else { return nil }

        let newNode = Node(node.val)
        newNode.left = dfsCopy(node.left)
        newNode.right = dfsCopy(node.right)

        return newNode
    }
}

/**
 Given two binary trees, write a function to check if they are the same or not.
 Two binary trees are considered the same if they are structurally identical and the
 nodes have the same value.

 Input:     1         1
           / \       / \
          2   3     2   3

         [1,2,3],   [1,2,3]

 Output: true
 */
class Solution {
    func isSameTree<T: Comparable>(_ p: Node<T>?, _ q: Node<T>?) -> Bool {
        if p == nil && q == nil {
            return true
        }

        // If either nodes are nil, we consider them different.
        if p == nil || q == nil || p!.val != q!.val {
            return false
        }

        return isSameTree(p!.left, q!.left) && isSameTree(p!.right, q!.right)
    }
}

// Tree 1
var root = Node(3)
root.left = Node(9)
root.right = Node(20)
root.right?.left = Node(15)
root.right?.right = Node(7)

// Tree 2 (copy of Tree 1)
var root2 = root.copy()

// Tree 3
var root3 = Node(3)
root3.left = Node(9)
root3.right = Node(20)

print(Solution().isSameTree(root, root2))
print(Solution().isSameTree(root, root3))
