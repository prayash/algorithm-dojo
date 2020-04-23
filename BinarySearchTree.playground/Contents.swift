import Foundation

class Node<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: Node?
    private(set) public var left: Node?
    private(set) public var right: Node?

    init(value: T) {
        self.value = value
    }

    convenience init(array: [T]) {
        precondition(array.count > 0)

        self.init(value: array.first!)

        for v in array.dropFirst() {
            insert(v)
        }
    }

    var isRoot: Bool {
        return parent == nil
    }

    var isLeaf: Bool {
        return left == nil && right == nil
    }

    var isLeftChild: Bool {
        return parent?.left === self
    }

    var isRightChild: Bool {
        return parent?.right === self
    }

    var hasLeftChlid: Bool {
        return left != nil
    }

    var hasRightChild: Bool {
        return right != nil
    }

    var hasAnyChild: Bool {
        return hasLeftChlid || hasRightChild
    }

    var hasBothChildren: Bool {
        return hasRightChild && hasRightChild
    }

    var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }

    func insert(_ value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value)
            } else {
                left = Node(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value)
            } else {
                right = Node(value: value)
                right?.parent = self
            }
        }
    }

    func search(_ value: T) -> Node? {
        if value < self.value {
            return left?.search(value)
        } else if value > self.value {
            return right?.search(value)
        } else {
            return self
        }
    }

    func searchIteratively(_ value: T) -> Node? {
        var node: Node? = self

        while let n = node {
            if value < n.value {
                node = n.left
            } else if value > n.value {
                node = n.right
            } else {
                return node
            }
        }

        return nil
    }

    func reconnectParentTo(node: Node?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }

        node?.parent = parent
    }

    func minimum() -> Node {
        var node = self

        while let next = node.left {
            node = next
        }

        return node
    }

    func maximum() -> Node {
        var node = self

        while let next = node.right {
            node = next
        }

        return node
    }

    @discardableResult
    func remove() -> Node? {
        let replacement: Node?

        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }

        replacement?.remove()

        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement

        parent = nil
        left = nil
        right = nil

        return replacement
    }

    // The height of a node is the distance to its lowest leaf
    func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }

    func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }

    func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }

    func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }

    func map(formula: (T) -> T) -> [T] {
        var a = [T]()

        if let left = left {
            a += left.map(formula: formula)
        }

        a.append(formula(value))

        if let right = right {
            a += right.map(formula: formula)
        }

        return a
    }

    func toArray() -> [T] {
        return map { $0 }
    }

}

extension Node: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }

        s += "\(value)"

        if let right = right {
            s += " -> (\(right.description))"
        }

        return s
    }
}

typealias BinarySearchTree<T: Comparable> = Node<T>

//let tree = BinarySearchTree<Int>(array: [1, 2, 3, 4, 5, 6])
let tree = BinarySearchTree<Int>(array: [8, 10, 9, 3, 5, 4, 6])

print(tree)

tree.search(2)

tree.traverseInOrder {
    print($0)
}

tree.traversePreOrder {
    print($0)
}

tree.traversePostOrder {
    print($0)
}

print(tree.toArray())

tree.minimum()
tree.maximum()

size(ofValue: Node.self)
