/**
 Convert a Binary Search Tree to a sorted Circular Doubly-Linked List in place.

 You can think of the left and right pointers as synonymous to the predecessor and successor
 pointers in a doubly-linked list. For a circular doubly linked list, the predecessor of the
 first element is the last element, and the successor of the last element is the first element.

 We want to do the transformation in place. After the transformation, the left pointer of
 the tree node should point to its predecessor, and the right pointer should point to its
 successor. You should return the pointer to the smallest element of the linked list.
 */

class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    /**
     DFS in-order traversal.
     - Complexity: O(n) time since each node is processed once. O(n) space for call-stack.
     */
    func treeToDoublyLinkedList(_ root: Node?) -> Node? {
        guard let root = root else {
            return nil
        }

        let dummy = Node(0)
        var prev: Node? = dummy
        traverse(root, &prev)

        // Connect head and tail
        // Once the traversal is done, prev is the final node
        // dummy.right is only set once during traversal, it is the smallest node
        prev?.right = dummy.right
        dummy.right?.left = prev

        // Return the head of the linked-list!
        return dummy.right
    }

    func traverse(_ node: Node?, _ prev: inout Node?) {
        guard let node = node else {
            return
        }

        traverse(node.left, &prev)

        // Set the double-link
        prev?.right = node
        node.left = prev
        prev = node

        traverse(node.right, &prev)
    }
}
