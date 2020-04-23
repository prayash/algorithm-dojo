/**
 Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
     push(x) -- Push element x onto stack.
     pop() -- Removes the element on top of the stack.
     top() -- Get the top element.
     getMin() -- Retrieve the minimum element in the stack.

     MinStack minStack = new MinStack();
     minStack.push(-2);
     minStack.push(0);
     minStack.push(-3);
     minStack.getMin();   --> Returns -3.
     minStack.pop();
     minStack.top();      --> Returns 0.
     minStack.getMin();   --> Returns -2.
 */

class MinStack {

    // Create an internal store for holding tuples
    var stack = [(val: Int, min: Int)]()

    init() {

    }

    // Each tuple in the stack holds the smallest minimum it has encountered
    func push(_ x: Int) {
        stack.append((x, min(stack.last?.min ?? x, x)))
    }

    func pop() {
        stack.popLast()
    }

    func top() -> Int {
        return stack.last!.val
    }

    func getMin() -> Int {
        return stack.last!.min
    }
}
