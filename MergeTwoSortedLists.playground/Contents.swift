/**
 Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.
 Input: 1->2->4, 1->3->4
 Output: 1->1->2->3->4->4
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
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else { return l2 }
        guard let l2 = l2 else { return l1 }

        var result: ListNode? = nil

        if l1.val <= l2.val {
            result = l1
            result?.next = mergeTwoLists(l1.next, l2)
        } else {
            result = l2
            result?.next = mergeTwoLists(l1, l2.next)
        }

        return result
    }
}

let listOne = ListNode(1)
listOne.next = ListNode(2)
listOne.next?.next = ListNode(4)

let listTwo = ListNode(1)
listTwo.next = ListNode(3)
listTwo.next?.next = ListNode(4)

print(Solution().mergeTwoLists(listOne, listTwo)!)
