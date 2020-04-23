/**
 An array is monotonic if it is either monotone increasing or monotone decreasing.

     An array A is monotone increasing if for all i <= j, A[i] <= A[j].
     An array A is monotone decreasing if for all i <= j, A[i] >= A[j].

 Return true if and only if the given array A is monotonic.
 */

class Solution {
    // Take a single pass comparing values by pairs. O(n) time and O(1) space.
    func isMonotonic(_ A: [Int]) -> Bool {
        var isIncreasing = true
        var isDecreasing = true

        for i in 0..<A.count - 1 {
            let current = A[i]
            let next = A[i + 1]

            if current > next {
                isIncreasing = false
            }

            if current < next {
                isDecreasing = false
            }
        }

        return isDecreasing || isIncreasing
    }
}

print(Solution().isMonotonic([6, 5, 4, 4])) // true
print(Solution().isMonotonic([1, 3, 2])) // false
