/**
 Given an integer array nums, find the sum of the elements between indices i and j (i ≤ j), inclusive.
 The update(i, val) function modifies nums by updating the element at index i to val.

 Given nums = [1, 3, 5]

     sumRange(0, 2) -> 9
     update(1, 2)
     sumRange(0, 2) -> 8

 Note:
 The array is only modifiable by the update function.
 You may assume the number of calls to update and sumRange function is distributed evenly.
 */

class NumArray {

    var segmentTree: [Int]
    var size: Int

    init(_ nums: [Int]) {
        size = nums.count
        segmentTree = [Int].init(repeating: 0, count: size * 2)
        buildTree(nums)
    }

    func buildTree(_ n: [Int]) {
        var i = size
        var j = 0

        while i < 2 * size  {
            segmentTree[i] = n[j]
            i += 1
            j += 1
        }

        i = size - 1
        while i > 0 {
            segmentTree[i] = segmentTree[i * 2] + segmentTree[i * 2 + 1]

            i -= 1
        }
    }

    func update(_ i: Int, _ val: Int) {
        var position = i

        position += size
        segmentTree[position] = val

        while position > 0 {
            var left = position
            var right = position

            if position % 2 == 0 {
                right = position + 1
            } else {
                left = position - 1
            }

            segmentTree[position / 2] = segmentTree[left] + segmentTree[right]
            position = position / 2
        }
    }

    func sumRange(_ i: Int, _ j: Int) -> Int {
        var left = i + size
        var right = j + size
        var sum = 0

        while left <= right {
            // left is right child of parent
            if left % 2 == 1 {
                sum += segmentTree[left]
                left += 1
            }

            // right is left child of its parent
            if right % 2 == 0 {
                sum += segmentTree[right]
                right -= 1
            }

            left = left / 2
            right = right / 2
        }

        return sum
    }
}

/**
* Your NumArray object will be instantiated and called as such:
* let obj = NumArray(nums)
* obj.update(i, val)
* let ret_2: Int = obj.sumRange(i, j)
*/

let obj = NumArray([2, 4, 5, 7, 8, 9])
print("Segment Tree: \(obj.segmentTree)")
print(obj.sumRange(0, 2))




// Naive AF!
class NumArrayNaive {
    var nums: [Int]

    init(_ nums: [Int]) {
        self.nums = nums
    }

    func update(_ i: Int, _ val: Int) {
        self.nums[i] = val
    }

    /**
     Super naive range sum.
     - Complexity: O(n)
     */
    func sumRange(_ i: Int, _ j: Int) -> Int {
        var sum = 0
        for i in i...j {
            sum += self.nums[i]
        }

        return sum
    }
}
