/**
 A heap is a complete binary tree, also known as binary heap, that can
 be constructed using an array. Max heaps keep elements with a higher value have
 higher priority, while min heaps keep elements with lower values have higher priority.
 One important characteristic of a heap is known as the heap invariant or heap property.

 In a max heap, parent nodes must always contain a value that is grater than or equal
 to the value in its children. The root node will always contain the highest value.

 In a mean heap, parent nodes must always contain a value that is less than or equal to
 the value in its children. The root node always holds the lowest value.

 A heap is a complete binary tree, meaning that all levels must be filled except the last one.
 Things can't be added to another level until the preceeding one is filled completely.

 Useful applications of a heap include: calculating the max or min element of a collection,
 heap sort, constructing a priority queue, or constructing a graph algorithm (prim's or djikstra's)
 with a priority queue.
 */

struct Heap<E: Equatable> {

    var elements: [E] = []
    let priorityFunction: (E, E) -> Bool

    init(priorityFunction: @escaping (E, E) -> Bool, elements: [E] = []) {
        self.priorityFunction = priorityFunction
        self.elements = elements

        if !elements.isEmpty {
            // Loop through the array backwards and sift down all parent nodes
            // Loop through only half of the elements, because there's no point in sifting down
            // lead nodes, only parent nodes
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    func peek() -> E? {
        return elements.first
    }

    func leftChildIndex(ofParentAt index: Int) -> Int {
        return (2 * index) + 1
    }

    func rightChildIndex(ofParentAt index: Int) -> Int {
        return (2 * index) + 2
    }

    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }

    // O(log n)
    mutating func remove() -> E? {
        guard !isEmpty else { return nil }

        // Swap the root node with the last element in the heap
        elements.swapAt(0, count - 1)

        // Make sure to re-validate the tree once the function executes
        defer {
            siftDown(from: 0)
        }

        // Return the element we just removed
        return elements.removeLast()
    }

    // O(log n)
    mutating func insert(_ element: E) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }

    // O(log n)
    mutating func siftDown(from index: Int) {
        var parent = index

        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)

            // We use this to keep track of which index to swap with the parent
            var candidate = parent

            // Check if any of the children have greater values than the current
            if left < count && priorityFunction(elements[left], elements[candidate]) {
                candidate = left
            }

            if right < count && priorityFunction(elements[right], elements[candidate]) {
                candidate = right
            }

            if candidate == parent {
                return
            }

            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }

    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)

        // Swap the current node with the parent, as long as the node
        // has higher priority than its parent
        while child > 0 && priorityFunction(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }

    // O(log n)
    mutating func remove(at index: Int) -> E? {
        guard index < elements.count else { return nil }

        // Removing the last element is very simple
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            // If not removing the last element, swap the element with the last element
            elements.swapAt(index, elements.count - 1)

            // We need to do this to sort the priorities again
            defer {
                siftDown(from: index)
                siftUp(from: index)
            }

            return elements.removeLast()
        }
    }

    // Heaps aren't the best for searching.. O(n)
    func index(of element: E, startingAt i: Int) -> Int? {
        // Search fails for obvious reasons
        if i >= count {
            return nil
        }

        // If the element we're looking for has higher priority than current index.. fail
        if priorityFunction(element, elements[i]) {
            return nil
        }

        // If the element is equal to the starting index, BOOM.
        if element == elements[i] {
            return i
        }

        // Recursively search for the element starting from the left child of i.
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            return j
        }

        // Recursively search for the element starting from the right child of i.
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            return j
        }

        // Search failed.
        return nil
    }

}

var heap = Heap(priorityFunction: <, elements: [3, 2, 8, 5, 0])


print(heap.elements)

heap.peek()
