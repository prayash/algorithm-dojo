/**
 Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

 Input:
 [
   1->4->5,
   1->3->4,
   2->6
 ]
 Output: 1->1->2->3->4->4->5->6
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
     Brute force solution would be to take the LLs, serialize all values into a single array,
     sort that array, then convert it back into a Linked List. Collecting all values would
     cost O(n) time, stable sorting would be O(n log n), and creating the LL would be O(n).
     Space, probably O(n) because we need to sort and create a new linked list.
     */
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard !lists.isEmpty else { return nil }

        var temp = [Int]()

        lists.forEach { head in
            var currentNode = head

            while currentNode != nil {
                if let value = currentNode?.val {
                    temp.append(value)
                }

                currentNode = currentNode?.next
            }
        }

        temp.sort()

        let holder = ListNode(0)
        var head: ListNode = holder

        for val in temp {
            head.next = ListNode(val)
            head = head.next!
        }

        // Return the list that's after the dummy starter node
        return holder.next
    }
}

let listOne = ListNode(1)
listOne.next = ListNode(4)
listOne.next?.next = ListNode(5)

let listTwo = ListNode(1)
listTwo.next = ListNode(3)
listTwo.next?.next = ListNode(4)

let listThree = ListNode(2)
listThree.next = ListNode(6)

let lists = [listOne, listTwo, listThree]

print(Solution().mergeKLists(lists)!)
