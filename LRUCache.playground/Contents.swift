/**
 Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and put.

 get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
 put(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

 The cache is initialized with a positive capacity.

 Follow up:
 Could you do both operations in O(1) time complexity?
 */

class LRUCache {

    /// A `Node` class in order to create an internal Linked List
    class Node {
        var key: Int
        var value: Int

        var prev: Node?
        var next: Node?

        init(_ key: Int, _ value: Int) {
            self.key = key
            self.value = value
        }
    }

    var capacity: Int
    var count: Int

    var head: Node?
    var tail: Node?
    var map: [Int: Node] = [:]

    init(_ capacity: Int) {
        self.capacity = capacity
        self.count = 0

        // We will use "dummy" nodes for the "head" and "tail". This will
        // let us omit head == null checks for adding to the list, which also
        // improves performance on the common operation of inserting into our list.
        self.head = Node(-1, -1)
        self.tail = Node(-1, -1)

        self.head?.next = tail
        self.tail?.prev = head
    }

    func get(_ key: Int) -> Int {
        guard let node = map[key] else {
            return -1
        }

        delete(node)
        moveToHead(node)

        return node.value
    }

    func put(_ key: Int, _ value: Int) {
        if let node = map[key] {
            node.value = value
            delete(node)
            moveToHead(node)

            return
        }

        let node = Node(key, value)
        map[key] = node

        if count == capacity, let node = tail?.prev {
            delete(node)
            map[node.key] = nil
            count = count - 1
        }

        moveToHead(node)
        count = count + 1
    }

    func delete(_ node: Node) {
        node.next?.prev = node.prev
        node.prev?.next = node.next
    }

    func moveToHead(_ node: Node) {
        node.next = head?.next
        node.next?.prev = node
        node.prev = head
        head?.next = node
    }
}

extension LRUCache: CustomStringConvertible {
    var description: String {
        var text = "["
        var node = head

        while node != nil {
            text += "\(node!.value)"
            node = node?.next

            if node != nil {
                text += "] <-> ["
            }
        }

        return "\(text)]"
    }
}

let cache = LRUCache(4)

cache.put(0, 0)
cache.put(1, 1)
cache.put(2, 3)
print(cache)

cache.get(0)
print(cache)
