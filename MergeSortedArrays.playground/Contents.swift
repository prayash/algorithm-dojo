/**
 Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.

 Note:
 The number of elements initialized in nums1 and nums2 are m and n respectively.
 You may assume that nums1 has enough space (size that is greater or equal to m + n) to
 hold additional elements from nums2.

     Input:
     nums1 = [1,2,3,0,0,0], m = 3
     nums2 = [2,5,6],       n = 3

     Output: [1,2,2,3,5,6]
 */
class Solution {
    /**
     Merge the array merge-sort style using two pointers, starting from the beginning.
     We'll compare as we move the pointers along and overwrite the `nums1` array using a copy.

     - Complexity: O(n + m)
     */
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        let copy: [Int] = nums1

        var i = 0
        var j = 0
        var ptr = 0

        while (i < m) && (j < n) {
            if copy[i] < nums2[j] {
                nums1[ptr] = copy[i]

                ptr += 1
                i += 1
            } else {
                nums1[ptr] = nums2[j]

                ptr += 1
                j += 1
            }
        }

        while i < m {
            nums1[ptr] = copy[i]
            ptr += 1
            i += 1
        }

        while j < n {
            nums1[ptr] = nums2[j]
            ptr += 1
            j += 1
        }
    }
}

var nums1 = [1, 2, 3, 0, 0, 0]
Solution().merge(&nums1, 3, [2, 5, 6], 3)
print(nums1)
