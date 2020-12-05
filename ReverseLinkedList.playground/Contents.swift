/**
 Reverse a singly linked list.

 Example:

 Input: 1->2->3->4->5->NULL
 Output: 5->4->3->2->1->NULL
 */

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        var text = "["
        var node: ListNode? = self

        while node != nil {
            text += "\(node!.val)"
            node = node!.next

            if node != nil {
                text += " -> "
            }
        }

        return text + "]"
    }
}

class Solution {
    /**
     `O(n)` time where `n` is list length, and `O(1)` space because
     we're just iterating through the whole thing, switching the
     relationships of the nodes as we go.
     */
    func reverseList(_ head: ListNode?) -> ListNode? {
        var previousNode: ListNode? = nil
        var currentNode: ListNode? = head

        // currentNode is our pointer to move through the list
        while currentNode != nil {
            // Store the next node in a temp variable
            let nextNode = currentNode?.next

            // Overwrite the next node with the previousNode
            currentNode?.next = previousNode

            // Previous node becomes the current node
            previousNode = currentNode

            // Set currentNode to next to keep moving forward until the tail!
            currentNode = nextNode
        }

        return previousNode
    }

    /**
     O(n) time where n is list length and O(n) space
     Visualization of recursive method: https://youtu.be/MRe3UsRadKw
     */
    func reverseListRecursively(_ head: ListNode?) -> ListNode? {
        // These conditions are for when we've reached the end of the list
        // and can start reversal
        if head == nil || head?.next == nil {
            return head
        }

        // Keep traversing the list and call stack until we reach the tail
        let current = head
        let newHead = reverseListRecursively(current?.next)

        // At this point, we're resolving all the stack calls
        // These ops reverse the relationship of the nodes in
        // a backward fashion
        current?.next?.next = current
        current?.next = nil

        return newHead
    }
}

var input = ListNode(1)
input.next = ListNode(2)
input.next?.next = ListNode(3)
input.next?.next?.next = ListNode(4)

print(Solution().reverseListRecursively(input)!)
