/**
 Given a singly linked list, return a random node's value from the linked list. Each node
 must have the same probability of being chosen.

 Follow up:
 What if the linked list is extremely large and its length is unknown to you? Could you solve
 this efficiently without using extra space?

 Init a singly linked list [1,2,3].
 ListNode head = new ListNode(1);
 head.next = new ListNode(2);
 head.next.next = new ListNode(3);
 Solution solution = new Solution(head);

 getRandom() should return either 1, 2, or 3 randomly. Each element should have equal
 probability of returning.
 solution.getRandom();
 */

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

/**
 We can count the length of the list, and then return a random Int R between 0 and length.
 Then we traverse the list again and stop at R stops and return that Node.
 To do it in a single pass, we'll use a random range. Then we don't need extra space, so
 O(1) space and O(n) time, worst case we'll iterate n times if R == n.
 */
class Solution {
    var head: ListNode?

    /** @param head The linked list's head.
     Note that the head is guaranteed to be not null, so it contains at least one node. */
    init(_ head: ListNode?) {
        self.head = head
    }

    /** Returns a random node's value. */
    func getRandom() -> Int {
        var count = 1
        var result = -1

        var currentNode = self.head
        while currentNode != nil {
            if Int.random(in: 0..<count) == 0 {
                result = currentNode!.val
            }

            currentNode = currentNode!.next
            count += 1
        }

        return result
    }
}

let head = ListNode(4)
head.next = ListNode(2)
head.next?.next = ListNode(0)
let obj = Solution(head)

for _ in 0...10 {
    let randomNode: Int = obj.getRandom()
    print(randomNode)
}

