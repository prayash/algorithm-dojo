/**
 Implement the following operations of a queue using stacks.

     push(x) -- Push element x to the back of queue.
     pop() -- Removes the element from in front of queue.
     peek() -- Get the front element.
     empty() -- Return whether the queue is empty.
 */
class QueueWithStacks {

    var stack: [Int] = []
    var auxiliary: [Int] = []

    /**
     Push element x to the back of the queue.
     */
    func push(_ x: Int) {
        while !stack.isEmpty {
            auxiliary.append(stack.removeLast())
        }

        stack.append(x)

        while !auxiliary.isEmpty {
            stack.append(auxiliary.removeLast())
        }
    }

    /**
     Removes the element from in front of queue and returns that element.
     */
    func pop() -> Int {
        return stack.removeLast()
    }

    /**
     Get the front element.
     */
    func peek() -> Int {
        return stack[stack.count - 1]
    }

    /**
     Returns whether the queue is empty.
     */
    func empty() -> Bool {
        return stack.isEmpty
    }
}

/**
 * Your QueueWithStacks object will be instantiated and called as such:
 * let obj = QueueWithStacks()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.peek()
 * let ret_4: Bool = obj.empty()
 */

let obj = QueueWithStacks()
obj.push(1)
obj.push(2)
obj.push(3)

obj.empty()
obj.pop()
obj.pop()
obj.pop()
obj.empty()
