/**
 Create a class LightString to manage a string of lights, each of which has a value 0 or 1
 indicating whether it is on or off.

 This is an interesting problem for discussing trade-offs. Here are three options and their
 worst-case time complexities (where `n` is the number of lights and `k` is the number of toggles):

 - Complexity:
     - Store each light state: O(n) `toggle()`, O(1) `isOn()`
     - Use a segment tree: O(log k) `toggle()`, O(log k) `isOn()`
     - Store each toggle: O(1) `toggle()`, O(k) `isOn()`
 */

class LightString {

    var data: SegmentTree<Int>

    init(_ n: Int) {
        self.data = SegmentTree(array: [Int].init(repeating: 0, count: n), 0, n - 1, +)
    }

    /**
     Return if the i-th light is on or off.
     */
    func isOn(at index: Int) -> Bool {
        return data.query(0, index) % 2 != 0
    }

    /**
     Switch state (turn on if it's off, turn off if it's on) of every light in the range [start, end].
     */
    func toggle(start: Int, end: Int) -> () {
        data.update(at: start, withItem: 1)
        data.update(at: end + 1, withItem: -1)
    }

}


/**
 Segment Trees are a type of binary tree.

 For an array of data type `T` and associative function `f`, if our task is to answer queries
 for a given internal (i.e perform `f(a[i...j])`, or to support replacing an item at some index `k`,
 we can do it all in O(log n) time where n is the size of initialization array.

 If our array is [1, 2, 3, 4] and the function is `f = (a + b)` then our tree looks like:

                      10 [0...3]
                    /    \
        [0...1]    3      7 [2...3]
                  / \    / \
             [0] 1   2  3   4 [3]

 */
class SegmentTree<T> {
    var value: T
    var f: (T, T) -> T
    var start: Int
    var end: Int
    var left: SegmentTree<T>?
    var right: SegmentTree<T>?

    /**
     Initialize a segment tree with the given bounds and function.
     - Complexity: Building the initial tree is an O(n log n) operation.
     */
    init(array: [T], _ start: Int, _ end: Int, _ f: @escaping (T, T) -> T) {
        self.start = start
        self.end = end
        self.f = f

        // If it's a leaf node, terminate the recursion.
        if start == end {
            value = array[start]
        } else {
            let middle = (start + end) / 2

            left = SegmentTree<T>(array: array, start, middle, f)
            right = SegmentTree<T>(array: array, middle + 1, end, f)

            value = f(left!.value, right!.value)
        }
    }

    /**
     Query the value of the associative function `f`, given a range as bounds.
     - Complexity: O(log n)
     */
    func query(_ start: Int, _ end: Int) -> T {
        // Check if the query segment is equal to the segment for which the current node is responsible.
        if self.start == start && self.end == end {
            return self.value
        }

        guard let left = self.left else { fatalError() }
        guard let right = self.right else { fatalError() }

        // If the query segment lies fully within the right child
        if start > left.end {
            return right.query(start, end)
        }

        // If the query segment fully lies within the left child
        if end < right.start {
            return left.query(start, end)
        } else {
            // Our query partially lies in both children, so we combine the result of two queries
            let left = left.query(start, left.end)
            let right = right.query(right.start, end)

            return f(left, right)
        }
    }

    /**
     Update an item at the given index.

     The value of a node depends on the nodes below it.
     If we change a value of a leaf node, all parent nodes need to be recalculated.
     - Complexity: O(log n)
     */
    func update(at index: Int, withItem item: T) {
        // If the node is a leaf, we just change its value
        if start == end {
            value = item
        }

        if let left = left, let right = right {
            if left.end >= index {
                left.update(at: index, withItem: item)
            } else {
                right.update(at: index, withItem: item)
            }

            value = f(left.value, right.value)
        }
    }
}

let lightString = LightString(5)        // All lights are initially off!
lightString.isOn(at: 0)                 // false
lightString.isOn(at: 1)                 // false
lightString.isOn(at: 2)                 // false
lightString.toggle(start: 0, end: 2)
lightString.isOn(at: 0)                 // true
lightString.isOn(at: 1)                 // true
lightString.isOn(at: 2)                 // true
lightString.isOn(at: 3)                 // false
lightString.toggle(start: 1, end: 3)
lightString.isOn(at: 1)                 // false
lightString.isOn(at: 2)                 // false
lightString.isOn(at: 3)                 // true

let array = [1, 2, 3, 4]
let sumSegmentTree = SegmentTree(array: array, 0, 3, +)
sumSegmentTree.query(0, 3)  // 1 + 2 + 3 + 4 = 10
sumSegmentTree.query(1, 3)  // 2 + 3 + 4 = 9
sumSegmentTree.query(1, 2)  // 2 + 3 = 5
sumSegmentTree.query(0, 0)  // just 1
sumSegmentTree.query(3, 3)  // just 4
