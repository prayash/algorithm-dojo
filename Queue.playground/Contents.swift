/// LinkedList
class LinkedList<T> {
    class Node<T> {
        var value: T
        var next: Node<T>?

        // To avoid ownership cycles, we declare the previous pointer to be weak.
        // If you have node A that is followed by node B in the list, then A points to B,
        // but B also points to A. In certain circumstances this retain cycle can cause nodes
        // to be kept alive even after deletion. We don't want that. so we'll make
        // one of the pointers weak to break the cycle.
        weak var prev: Node<T>?

        init(value: T) {
            self.value = value
        }
    }
    
    private var head: Node<T>?
    private var tail: Node<T>?

    var isEmpty: Bool {
        return head === nil
    }

    var first: Node<T>? {
        return head
    }

    var last: Node<T>? {
        return tail
    }

    func append(_ value: T) -> Node<T> {
        let node = Node<T>(value: value)

        // Since we're appending to the LL, if there's already a tail
        // let's set the tail node's next to the new node and make the new
        // node point to the tail
        if let tailNode = tail {
            node.prev = tailNode
            tailNode.next = node
        } else {
            // If the tail is null, that means the list is empty, so make
            // our new Node the head
            head = node
        }

        // In any case, a newly added Node is always going to become the tail!
        tail = node

        return node
    }

    func nodeAt(index: Int) -> Node<T>? {
        if index >= 0 {
            var node = head
            var i = index

            while node != nil {
                if i == 0 { return node }

                i -= 1
                node = node!.next
            }
        }

        return nil
    }

    func remove(node: Node<T>) -> T {
        // If the node has a prev, take the prev's next and
        // point it to node.next
        if let prev = node.prev {
            prev.next = node.next
        } else {
            // If it doesn't have a prev, that means it's the first item.
            // Set the head to the next node
            head = node.next
        }

        // Update the tail if we're removing the last node of the list
        if node.next == nil {
            tail = node.prev
        }

        // We'll want to set the prev pointer of the next node
        // to the prev of the node being deleted
        node.next?.prev = node.prev

        // In all cases, we'll want to nullify the next and prev of the
        // node that is being deleted
        node.next = nil
        node.prev = nil

        return node.value
    }

    func removeAll() -> Void {
        head = nil
        tail = nil
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var text = "["
        var node = head

        while node != nil {
            text += "\(node!.value)"
            node = node!.next

            if node != nil {
                text += "] <–> ["
            }
        }

        return "\(text)]"
    }
}

struct Queue<T>: CustomStringConvertible {

    // We'll use a Linked List to hold a bunch of items. We could use an array,
    // but a linked list can hold as many objects as memory can hold (not fixed size)
    // and it can grow easily withouting having to copy over the old contents like an array.
    // Copying over is the problem incurred with a dynamic array that has to be made bigger.
    private var list = LinkedList<T>()

    var isEmpty: Bool {
        return list.isEmpty
    }

    mutating func enqueue(_ element: T) {
        list.append(element)
    }

    mutating func dequeue() -> T? {
        // Let's ensure the list isn't empty, and that there's at least one item in it.
        // We'll always return the first item, because FIFO!
        guard !list.isEmpty, let element = list.first else {
            return nil
        }

        list.remove(node: element)

        return element.value
    }

    func peek() -> T? {
        return list.first?.value
    }

    var description: String {
        return list.description
    }

}

var q = Queue<Int>()
q.enqueue(3)
q.enqueue(4)
q.enqueue(5)

print(q)

print("Dequeuing...")
q.dequeue()
print(q)
