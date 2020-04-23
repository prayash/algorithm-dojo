/**

 */

struct Heap<E> {
    var elements: [E]
    let priorityFunction: (E, E) -> Bool

    init(elements: [E] = [], priorityFunction: @escaping (E, E) -> Bool) {
        self.elements = elements
        self.priorityFunction = priorityFunction

        // Build the heap
        for index in (0..<count / 2).reversed() {
            siftDown(elementAtIndex: index)
        }
    }

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    func isRoot(_ index: Int) -> Bool { index == 0 }
    func leftChildIndex(of index: Int) -> Int { (2 * index) + 1 }
    func rightChildIndex(of index: Int) -> Int { (2 * index) + 2 }
    func parentIndex(of index: Int) -> Int { (index - 1) / 2 }
    func peek() -> E? { elements.first }

    mutating func enqueue(_ element: E) {
        elements.append(element)
        siftUp(elementAtIndex: count - 1)
    }

    mutating func siftUp(elementAtIndex index: Int) {
        let parent = parentIndex(of: index)

        // Ensure we're not trying to sift up the root node of the heap
        // Or sift an element above a higher priority parent
        guard !isRoot(index), isHigherPriority(at: index, than: parent) else {
            return
        }

        // Swap the index with the parent now that we know it should be higher
        swapElement(at: index, with: parent)

        // Repeat for the parent index, because it might not be in position
        siftUp(elementAtIndex: parent)
    }

    mutating func siftDown(elementAtIndex index: Int) {
        let childIndex = highestPriorityIndex(for: index)
        if index == childIndex {
            return
        }

        swapElement(at: index, with: childIndex)
        siftDown(elementAtIndex: childIndex)
    }

    /**
     Wrapper for the priority function property. It takes two indices and
     returns true if the element at the first index has higher priority.
     */
    func isHigherPriority(at first: Int, than second: Int) -> Bool {
        return priorityFunction(elements[first], elements[second])
    }

    /**
     Assumes that a parent node has a valid index in the array, and then compares the
     priorities of the nodes at those indices, returning a valid index for whichever node
     has the highest priority.
     */
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < count && isHigherPriority(at: childIndex, than: parentIndex) else {
            return parentIndex
        }

        return childIndex
    }

    /**
     Assumes the parent node index is valid, and compares the index to both of its
     left and right children (if they exist). Whichever of the three has the highest priority
     is the index that is returned.
     */
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)), and: rightChildIndex(of: parent))
    }

    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex else { return }

        elements.swapAt(firstIndex, secondIndex)
    }

}

var heap = Heap(elements: [3, 2, 8, 5, 0], priorityFunction: <)

print(heap.elements)
