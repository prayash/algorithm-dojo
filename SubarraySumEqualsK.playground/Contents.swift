/**
 Given an array of integers and an integer k, you need to find the total number of
 continuous subarrays whose sum equals to k.

 Input:nums = [1,1,1], k = 2
 Output: 2
 */

class Solution {
    /**
     🤮 Brute-force.. O(n ^ 3) time. n * n for the two loops, and another n for the summation.
     */
    func subarraySumNaive(_ nums: [Int], _ k: Int) -> Int {
        var count = 0

        for i in 0..<nums.count {
            for j in i + 1...nums.count {
                if Array(nums[i..<j]).reduce(0, +) == k {
                    count += 1
                }
            }
        }

        return count
    }

    /**
     😎 O(n) time and O(1) space using a hash map. Build a table with keys
     a cumulative sum moving across the array. The value will be the count of how many times
     we've seen that sum. If the cumulative sum upto two indices, say ii and jj is at
     a difference of k i.e. if sum[i] - sum[j] = k, the sum of elements
     lying between indices i and j is k.
     */
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var hashMap: [Int : Int] = [0:1]
        var count = 0
        var sum = 0

        for number in nums {
            sum += number

            // If at any point our hashmap has the sum - k value, that means
            // we can build a sum k
            if hashMap[sum - k] != nil {
                count += hashMap[sum - k]!
            }

            hashMap[sum] = hashMap[sum, default: 0] + 1
        }

        return count
    }
}

//print(Solution().subarraySumNaive([1, 1, 1], 2))
print(Solution().subarraySumNaive([1, 2, 3], 3))
