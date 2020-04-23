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
    var leftBound: Int
    var rightBound: Int
    var left: SegmentTree<T>?
    var right: SegmentTree<T>?

    /**
     Initialize a segment tree with the given bounds and function.
     - Complexity: Building the initial tree is an O(n) operation.
     */
    init(array: [T], _ leftBound: Int, _ rightBound: Int, _ f: @escaping (T, T) -> T) {
        self.leftBound = leftBound
        self.rightBound = rightBound
        self.f = f

        // If it's a leaf node, terminate the recursion.
        if leftBound == rightBound {
            value = array[leftBound]
        } else {
            let middle = (leftBound + rightBound) / 2

            left = SegmentTree<T>(array: array, leftBound, middle, f)
            right = SegmentTree<T>(array: array, middle + 1, rightBound, f)

            value = f(left!.value, right!.value)
        }
    }

    /**
     Query the value of the associative function `f`, given a range as bounds.
     - Complexity: O(log n)
     */
    func query(_ leftBound: Int, _ rightBound: Int) -> T {
        // Check if the query segment is equal to the segment for which the current node is responsible.
        if self.leftBound == leftBound && self.rightBound == rightBound {
            return self.value
        }

        guard let left = left else { fatalError() }
        guard let right = right else { fatalError() }

        // If the query segment lies fully within the right child
        if left.rightBound < leftBound {
            return right.query(leftBound, rightBound)
        }

        // If the query segment fully lies within the left child
        if right.leftBound > rightBound {
            return left.query(leftBound, rightBound)
        } else {
            // Our query partially lies in both children, so we combine the result of two queries
            let left = left.query(leftBound, left.rightBound)
            let right = right.query(right.leftBound, rightBound)

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
        if leftBound == rightBound {
            value = item
        }

        if let left = left, let right = right {
            if left.rightBound >= index {
                left.update(at: index, withItem: item)
            } else {
                right.update(at: index, withItem: item)
            }

            value = f(left.value, right.value)
        }
    }
}

let array = [1, 2, 3, 4]
let sumSegmentTree = SegmentTree(array: array, 0, 3, +)
sumSegmentTree.query(0, 3)  // 1 + 2 + 3 + 4 = 10
sumSegmentTree.query(1, 2)  // 2 + 3 = 5
sumSegmentTree.query(0, 0)  // just 1
sumSegmentTree.query(3, 3)  // just 4
