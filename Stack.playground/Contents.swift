struct Stack<Element> {
    private var array: [Element] = []

    var isEmpty: Bool {
        return array.isEmpty
    }

    var count: Int {
        return array.count
    }

    mutating func push(_ element: Element) {
        // Inserting at the beginning of an array is O(n).. expensive.
        // We don't want to shift all contents by 1 just to insert a new element.
        // Let's opt for adding at the end of the array, which is O(1).
        array.append(element)
    }

    mutating func pop() -> Element? {
        return array.popLast()
    }

    func peek() -> Element? {
        return array.last
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let top = "= = = = =\n"
        let bottom = "\n= = = = =\n"

        let elements = array.map{ "\($0)" }.reversed().joined(separator: "\n- - - - -\n")
        return top + elements + bottom
    }
}


var stack = Stack<String>()
stack.push("Item 1")
stack.push("Item 2")
stack.push("Item 3")

print(stack)

stack.peek()
stack.pop()
stack.peek()
stack.pop()

print("After 2 pops and a peek...")
print(stack)

stack.isEmpty
stack.count
