/**
 Implement an iterator over a binary search tree (BST). Your iterator will be initialized with the root node of a BST.

 Calling next() will return the next smallest number in the BST.
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

/**
 A Binary Search Tree iterator class. Pre-computed using in-order traversal of the tree, and constructing an array out of all values as they would be sorted in ascending order. We then maintain an internal index to keep track of the iterator state.

 We should also consider the stack space occupied by the recursive calls, but that is limited to O(h) where h is the height of the tree.
 - Complexity: O(n) for pre-computation. O(1) for querying. O(n) space :(
 */
class BSTIteratorNaive {
    var sortedNodes: [Int] = [Int]()
    var index: Int = 0

    init(_ root: TreeNode?) {
        inorderTraverse(root)
    }

    private func inorderTraverse(_ node: TreeNode?) {
        guard let node = node else {
            return
        }

        inorderTraverse(node.left)
        sortedNodes.append(node.val)
        inorderTraverse(node.right)
    }

    /** @return the next smallest number */
    func next() -> Int {
        defer {
            index += 1
        }

        return sortedNodes[index]
    }

    /** @return whether we have a next smallest number */
    func hasNext() -> Bool {
        return index < sortedNodes.count
    }
}

/**
 A better way of building a BST Iterator without a pre-processing step is to use a stack and some controlled recursion.
 - Complexity: O(n) worse-case for iteration, but O(1) amortized cost. O(log n) space for stack.
 */
class BSTIterator {
    var stack: [TreeNode] = [TreeNode]()

    init(_ root: TreeNode?) {
        guard let root = root else { return }

        proceed(from: root)
    }

    /** Controller in-order subroutine to store the next set of Nodes onto stack. */
    private func proceed(from node: TreeNode?) {
        var current: TreeNode? = node

        stack.append(current!)

        while current?.left != nil {
            current = current?.left
            stack.append(current!)
        }
    }

    /** @return the next smallest number */
    func next() -> Int {
        let node = stack.popLast()

        if let rightNode = node?.right {
            proceed(from: rightNode)
        }

        return node?.val ?? -1
    }

    /** @return whether we have a next smallest number */
    func hasNext() -> Bool {
        return stack.count > 0
    }
}

var root = TreeNode(7)
root.left = TreeNode(3)
root.right = TreeNode(15)
root.right?.left = TreeNode(9)
root.right?.right = TreeNode(20)

//let obj = BSTIteratorNaive(root)
//print(obj.hasNext())
//print(obj.next())
//print(obj.next())
//print(obj.next())
//print(obj.next())
//print(obj.hasNext())
//print(obj.next())
//print(obj.hasNext())

let obj = BSTIterator(root)
print(obj.hasNext())
print(obj.next())
print(obj.next())
print(obj.next())
print(obj.next())
print(obj.hasNext())
print(obj.next())
print(obj.hasNext())
print(obj.next())
