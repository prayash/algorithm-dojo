/**
 Given a nested list of integers, implement an iterator to flatten it.
 Each element is either an integer, or a list -- whose elements may also be integers or other lists.

 Input: [[1,1],2,[1,1]]
 Output: [1,1,2,1,1]
 Explanation: By calling next repeatedly until hasNext returns false,
              the order of elements returned by next should be: [1,1,2,1,1].
 */


// This is the interface that allows for creating nested lists.
// You should not implement it, or speculate about its implementation
class NestedInteger {
    // Return true if this NestedInteger holds a single integer, rather than a nested list.
    public func isInteger() -> Bool {
        return false
    }

    // Return the single integer that this NestedInteger holds, if it holds a single integer
    // The result is undefined if this NestedInteger holds a nested list
    public func getInteger() -> Int {
        return 1
    }

    // Set this NestedInteger to hold a single integer.
    public func setInteger(value: Int) {
    }

    // Set this NestedInteger to hold a nested list and adds a nested integer to it.
    public func add(elem: NestedInteger) {

    }

    // Return the nested list that this NestedInteger holds, if it holds a nested list
    // The result is undefined if this NestedInteger holds a single integer
    public func getList() -> [NestedInteger] {
        return []
    }
}

class NestedIterator {

    var currentIndex: Int = 0
    var values = [Int]()

    init(_ nestedList: [NestedInteger]) {
        for item in nestedList {
            transform(item)
        }
    }

    func next() -> Int {
        defer {
            currentIndex += 1
        }

        return values[currentIndex]
    }

    func hasNext() -> Bool {
        return currentIndex < values.count
    }

    func transform(_ nestedInt: NestedInteger) {
        if nestedInt.isInteger() {
            values.append(nestedInt.getInteger())
        } else {
            for item in nestedInt.getList() {
                transform(item)
            }
        }
    }
}

/**
 * Your NestedIterator object will be instantiated and called as such:
 * let obj = NestedIterator(nestedList)
 * let ret_1: Int = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */
