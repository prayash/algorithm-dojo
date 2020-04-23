/**
 Delete a node from a singly-linked list, given only a variable pointing to that node.
 */

class LinkedListNode<Value: Equatable> {
    var value: Value
    var next: LinkedListNode?

    init(_ value: Value) {
        self.value = value
    }
}

enum DeleteNodeError: Error, CustomStringConvertible {
    case lastNode

    var description: String {
        return "Can't delete the last node with this technique!"
    }
}

func deleteNode<T>(_ nodeToDelete: LinkedListNode<T>) throws {

    // get the input node's next node, the one we want to skip to
    guard let nextNode = nodeToDelete.next else {

        // eep, we're trying to delete the last node!
        throw DeleteNodeError.lastNode
    }

    // replace the input node's value and pointer with the next
    // node's value and pointer. the previous node now effectively
    // skips over the input node
    nodeToDelete.value = nextNode.value
    nodeToDelete.next = nextNode.next
    nextNode.next = nil
}

let a = LinkedListNode("A")
let b = LinkedListNode("B")
let c = LinkedListNode("C")

a.next = b
b.next = c

try deleteNode(b)
