/**
 Given two arrays, write a function to compute their intersection.

 Example 1:
 Input: nums1 = [1, 2, 2, 1], nums2 = [2, 2]
 Output: [2, 2]

 Example 2:
 Input: nums1 = [4, 9, 5], nums2 = [9, 4, 9, 8, 4]
 Output: [4, 9]
 */

class Solution {
    /**
     Two-pointer solution: O(n log n + m log m) time for sorting + scanning. Asymptotic complexity
     will either be O(n log n), or O(m log m), whichever array is longer.
     O(m + n) space because we sorted and allocated new arrays. Should we do it in-place?
     */
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var set = Set<Int>()
        let nums1 = nums1.sorted()
        let nums2 = nums2.sorted()
        var i = 0, j = 0

        while i < nums1.count && j < nums2.count {
            // If the nums match, add it to the result list and increment both pointers
            if nums1[i] == nums2[j] {
                if !set.contains(nums1[i]) {
                    set.insert(nums1[i])
                }

                i += 1
                j += 1
            } else if nums1[i] < nums2[j] {
                i += 1
            } else {
                j += 1
            }
        }

        return Array(set)
    }

    /**
     Set intersection approach. Convert both lists into sets, and iterate
     over the smaller set checking the presence of each element in the larger set.
     O(n + m) tim where n and m are array lengths.
     Space would also be O(m + n) space because we convert both arrays into Sets.
     */
    func setIntersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var setOne = Set(nums1)
        var setTwo = Set(nums2)

        for num in nums1 { setOne.insert(num) }
        for num in nums2 { setTwo.insert(num) }

        if setOne.count < setTwo.count {
            return helper(setOne, setTwo)
        } else {
            return helper(setTwo, setOne)
        }
    }

    func helper(_ a: Set<Int>, _ b: Set<Int>) -> [Int] {
        var output = [Int]()

        for num in a {
            if b.contains(num) {
                output.append(num)
            }
        }

        return output
    }
}

print(Solution().intersection([4, 9, 5], [9, 4, 9, 8, 4]))
