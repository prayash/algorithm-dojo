/**
 You are given two non-empty linked lists representing two non-negative integers. The digits
 are stored in reverse order and each of their nodes contain a single digit. Add the two
 numbers and return it as a linked list.
 You may assume the two numbers do not contain any leading zero, except the number 0 itself.

 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 Explanation: 342 + 465 = 807.

 Input: (9 -> 9) + (1)
 Output: 0 -> 0 -> 1
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
     Elementary math method by adding each digit and carrying over its value, traversing the
     linked list.
     O(max(m, n)) time – the algorithm iterates at most max(m, n) times.
     O(max(m, n)) space – the length of the new list is at most max(m, n) + 1 for the carry-over.
     */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // Mutable pointers for list-traversal
        var m = l1
        var n = l2

        var carry = 0
        var current = ListNode(0)

        // We initialize a new Head to point to the dummy, like H(0) -> nil
        let head = current

        // Conditions for looping are:
        // 1. One of the lists must be non-empty
        // 2. Our carry value cannot be anything other than 0, otherwise data-loss!
        while m != nil || n != nil || carry != 0 {
            // If we've reached the end of one list, we'll just use 0
            let x = m?.val ?? 0
            let y = n?.val ?? 0

            let sum = x + y + carry

            // Update the carry
            carry = sum / 10

            // Set the value to a digit without carry (if there is one)
            current.next = ListNode(sum % 10)

            // Advance
            current = current.next!

            // Move pointers forward
            m = m?.next
            n = n?.next
        }

        return head.next
    }
}

var l1 = ListNode(2)
l1.next = ListNode(4)
l1.next?.next = ListNode(3)

var l2 = ListNode(5)
l2.next = ListNode(6)
l2.next?.next = ListNode(4)

print(Solution().addTwoNumbers(l1, l2)!)

l1 = ListNode(9)
l1.next = ListNode(9)

l2 = ListNode(1)

print(Solution().addTwoNumbers(l1, l2)!)
