/**
 Given an array nums sorted in ascending order, return true if and only if you can split it into 1 or more
 subsequences such that each subsequence consists of consecutive integers and has length at least 3.

 Example 1:
 Input: [1,2,3,3,4,5]
 Output: True
 Explanation:
 You can split them into two consecutive subsequences :
 1, 2, 3
 3, 4, 5

 Example 3:
 Input: [1,2,3,4,4,5]
 Output: False
 */

class Counter {
    var count: Dictionary<Int, Int> = [:]

    func get(_ key: Int) -> Int {
        return count[key] ?? 0
    }

    func add(_ key: Int, _ value: Int) {
        count[key] = self.get(key) + value
    }

}

class Solution {
    func isPossible(_ nums: [Int]) -> Bool {
        let freqMap = Counter()
        let tailMap = Counter()

        for n in nums {
            freqMap.add(n, 1)
        }

        for n in nums {
            if freqMap.get(n) == 0 {
                continue
            } else if tailMap.get(n) > 0 {
                // If the tail map has the next number in the sequence available
                // Use it, and add a new hypothetical one after
                tailMap.add(n, -1)
                tailMap.add(n + 1, 1)
            } else if freqMap.get(n + 1) > 0 && freqMap.get(n + 2) > 0 {
                // If the next two values in the sequence exist, use em!
                freqMap.add(n + 1, -1)
                freqMap.add(n + 2, -1)

                // Add the next hypothetical value to the tail map
                tailMap.add(n + 3, 1)
            } else {
                // If we can't add a number to the existing sequence or find two following numbers
                // Then we return.
                return false
            }

            freqMap.add(n, -1)
        }

        print(tailMap.count)

        return true
    }
}

//print(Solution().isPossible([1,2,3,3,4,5]))
print(Solution().isPossible([1,2,3,4,4,5]))
