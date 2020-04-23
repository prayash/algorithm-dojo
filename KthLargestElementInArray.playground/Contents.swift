/**
 Find the kth largest element in an unsorted array. Note that it is the kth largest
 element in the sorted order, not the kth distinct element.

 Input: [3, 2, 1, 5, 6, 4] and k = 2
 Output: 5

 Input: [3, 2, 3, 1, 2, 4, 5, 5, 6] and k = 4
 Output: 4
 */

class Solution {
    /**
     A straightforward way of doing this is by sorting the array first (O n log n), and returning
     the Kth element from the end. This would be O(1) space, but it's not fast enough. Instead,
     let's maintain a min heap of size k. Add each point to the heap, and if we ever exceed the
     capacity, then expel the smallest values.
     - Complexity: O(n log k) since insertions and removals in Heaps cost O(log k) where k is
     the heap size. The n comes from the fact that we have to do this operation n times.
     */
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var minHeap = Heap<Int>(sort: <)

        for n in nums {
            minHeap.insert(n)

            if minHeap.count > k {
                minHeap.remove()
            }
        }

//        print(minHeap.nodes)

        // The head of the heap is the Kth largest element
        return minHeap.remove() ?? 0
    }

    /**
     Use Quickselect, very similar to the Quicksort algorithm.
     - Complexity: O(n) in average case, O(n ^ 2) worst case if bad pivot chosen. O(1) space.
     */
    func findKthLargestQuickselect(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums

        func partition(_ left: Int, _ right: Int, _ pivotIdx: Int) -> Int {
            let pivot = nums[pivotIdx]

            // Move pivot to the end
            nums.swapAt(pivotIdx, right)
            var storeIdx = left

            // Move all smaller elements to the left
            for i in left...right {
                if nums[i] < pivot {
                    nums.swapAt(storeIdx, i)
                    storeIdx += 1
                }
            }

            // Move the pivot to its final spot
            nums.swapAt(storeIdx, right)

            print(nums, storeIdx)

            return storeIdx
        }

        func quickSelect(_ l: Int, _ r: Int, _ kthSmallest: Int) -> Int {
            // If the list only contains one element
            if l == r { return nums[l] }

            var pivotIdx = Int.random(in: l...r)
            pivotIdx = partition(l, r, pivotIdx)

            if kthSmallest == pivotIdx {
                return nums[kthSmallest]
            } else if kthSmallest < pivotIdx {
                return quickSelect(l, pivotIdx - 1, kthSmallest)
            } else {
                return quickSelect(pivotIdx + 1, r, kthSmallest)
            }
        }

        return quickSelect(0, nums.count - 1, nums.count - k)
    }
}

//print(Solution().findKthLargest([3, 2, 1, 5, 6, 4], 2))
//print(Solution().findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))

print(Solution().findKthLargestQuickselect([3, 2, 1, 5, 6, 4], 2))
//print(Solution().findKthLargestQuickselect([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))
